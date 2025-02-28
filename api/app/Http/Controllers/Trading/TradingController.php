<?php

namespace App\Http\Controllers\Trading;

use App\Http\Controllers\Controller;
use App\Models\BuyToken;
use App\Models\MiningBalanceSum;
use App\Models\Setting;
use App\Models\Trade;
use App\Models\TradingCategory;
use App\Models\TradingDuration;
use App\Models\TradingSubCategory;
use App\Models\ManualAdjustment;
use Illuminate\Http\Request;
use Auth;
use Validator;
use Helper;
use App\Models\User;
use Illuminate\Support\Str;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;
use Session;
use DB;
use PhpParser\Node\Stmt\TryCatch;
use Illuminate\Http\JsonResponse;
use Carbon\Carbon;

class TradingController extends Controller
{
    protected $userid;
    protected $name;
    public function __construct()
    {
        $this->middleware('auth:api');
        $id = auth('api')->user();
        $user = User::find($id->id);
        $this->userid = $user->id;
        $this->name = $user->name;
    }


    public function insertTrading(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make($request->all(), [
            'market_price'         => 'required',
            'trade_amount'         => 'required',
            'selected_duration'    => 'required',
            'selected_percentage'  => 'required',
            'action_type'          => 'required',
            'selectedCurrency'     => 'required',
        ], [
            'market_price.required'      => 'Market price is required.',
            'trade_amount.required'      => 'Trade amount is required.',
            'selected_duration.required' => 'Duration is required.',
            'selected_percentage.required' => 'Percentage is required.',
            'action_type.required'       => 'Action type is required.',
            'selectedCurrency.required'  => 'Currency selection is required.',
        ]);



        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $userId  = $this->userid;
        $tradeID = $userId; // Assuming $userId is the tradeID
        $hash    = md5(time()); // Generate MD5 hash

        $customTimeZone = 'Asia/Dhaka';
        $currentTime    = Carbon::now($customTimeZone);
        $endTime        = Carbon::now($customTimeZone);
        $endTime->addSecond($request->selected_duration);
        // Format the datetime as needed
        $start_datetime    = $currentTime->format('Y-m-d H:i:s');
        $end_datetime      = $endTime->format('Y-m-d H:i:s');

        $data    = array(
            'unique_md5'           => $hash,
            'user_id'              => $userId,
            'market_price'         => $request->market_price,
            'trade_amount'         => $request->trade_amount,
            'selected_duration'    => $request->selected_duration,
            'selected_percentage'  => $request->selected_percentage,
            'action_type'          => strtoupper($request->action_type),
            'selectedCurrency'     => strtoupper($request->selectedCurrency),
            'start_datetime'       => $start_datetime,
            'status'               => 0,
            'end_datetime'         => $end_datetime
        );
        //dd($data);

        $response          = app('App\Http\Controllers\Balance\BalanceController')->getCurrentBalance();
        $currentBalance = $response instanceof JsonResponse ? $response->getData(true)['balance'] : 0;
        // echo $currentBalance;exit; 
        $tradingAmount     = !empty($request->trade_amount) ? $request->trade_amount : "";

        if ($tradingAmount > $currentBalance) {
            return response()->json([
                'errors' => [
                    'invalid_amount' => ["Sorry, the request is invalid. Your current balance is {$currentBalance} USDT."]
                ]
            ], 422);
        }
        // if ($tradingAmount < $request->min_trade) {
        //     return response()->json(['invalid_min_amount' => "Sorry, minimum trade request amount $request->min_trade USDT "], 422);
        // }
        $lastId             = Trade::insertGetId($data);
        $formatedNumbe      = sprintf('%06d', $lastId);
        Trade::where('id', $lastId)->update(['tradeID' => 'TID' . $formatedNumbe]);

        $response = [
            'message' => 'Your trade has been successfully started.',
        ];
        return response()->json($response, 200);
    }


    public function filterTradeHistory(Request $request)
    {

        $sDate              = $request->filterFrmDate;
        $eDate              = $request->filterToDate;
        $searchTranId       = $request->searchtxt;
        $selectedStatus     = $request->selectedFilter;
        $type               = $request->type;
        $startDate          = Carbon::parse($sDate)->startOfDay();
        $endDate            = Carbon::parse($eDate)->endOfDay();
        // dd($selectedFilter);
        $query = Trade::orderBy('trade.id', 'desc')
            ->join('users', 'trade.user_id', '=', 'users.id')
            ->select(
                'trade.*',
                'users.name',
                'users.username',
                'users.telegram',
                'users.phone_number',
                'users.whtsapp',
                'users.email'
            );
        if ($searchTranId !== null) {
            $query->where('trade.tradeID', 'like', '%' . $searchTranId . '%');
            //$query->where('users.email', $searchOrderId);
        }
        if ($selectedStatus !== null) {
            if ($selectedStatus == 5) {
                $query->whereIn('trade.status', [0, 1, 2]);
            } else {
                $query->where('trade.status', $selectedStatus);
            }
        }
        // Apply date range filtering if start and end dates are provided
        if ($startDate !== null && $endDate !== null) {
            $query->whereBetween('trade.created_at', [$startDate, $endDate]);
        }

        if ($type !== null) {
            $query->where('trade.action_type', $type);
        } else {
            $query->whereIn('trade.action_type', ['LONG', 'SHORT']);
        }

        //$query->whereIn('trade.id', [1, 2]);
        $results = $query->get();
        $modifiedCollection = $results->map(function ($item) {
            $tradeAmt = number_format($item->trade_amount, 2);

            $statusLabels = [
                1 => 'Active',
                0 => 'Pending',
            ];

            //Can update admin
            /*
            $actionStatus = "";
            if ($item->action_type == "LONG" && $item->market_price > $item->close_price) {
                $actionStatus =  "LOSS";
            } else {
                $actionStatus =  "WIN";
                $tradeeFee    =  0;
            }

            if ($actionStatus == "LOSS") {
                $closingPNL = "-$tradeAmt";
            } else {

                $tradeAmt = (float) $item->trade_amount; // Ensure it's a number
                $selected_percentage = (float) $item->selected_percentage; // Ensure it's a number
                // Calculate profit percentage
                $profitPercentage = ($tradeAmt * $selected_percentage) / 100;
                // Calculate Closing PNL
                $closingPNL = $tradeAmt + $profitPercentage - $tradeeFee;
            }
            */
            
            //END

            return [
                'id'                    => $item->id,
                'tradeID'               => $item->tradeID,
                'trade_date'            => date("Y-M-d", strtotime($item->created_at)),
                'trade_amount'          => number_format($item->trade_amount, 2),
                'selected_duration'     => $item->selected_duration,
                'selected_percentage'   => $item->selected_percentage,
                'action_type'           => $item->action_type, //short or long
                'username'              => $item->username,
                'market_price'          => $item->market_price,
                'close_price'           => $item->close_price,
                'selectedCurrency'      => $item->selectedCurrency,
                'start_datetime'        => $item->start_datetime,
                'end_datetime'          => $item->end_datetime,
                'actionStatus'          => $actionStatus,
                'closingPNL'            => number_format($closingPNL, 2),
                'fee'                   => number_format(0.00,2),
                'status'                => $item->status,
                'statusName'            => $statusLabels[$item->status] ?? 'Unknown'
            ];
        });

        // Return the modified collection along with pagination metadata
        return response()->json([
            'data' => $modifiedCollection,
        ], 200);
    }
}
