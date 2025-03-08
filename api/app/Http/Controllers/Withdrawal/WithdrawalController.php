<?php

namespace App\Http\Controllers\Withdrawal;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Auth;
use Validator;
use Helper;
use App\Models\Holiday;
use App\Models\User;
use App\Models\UserWalletAddress;
use App\Models\ProductVarrientHistory;
use App\Models\Categorys;
use App\Models\ProductAttributes;
use App\Models\ProductCategory;
use App\Models\Product;
use App\Models\ProductAdditionalImg;
use App\Models\ProductVarrient;
use App\Models\AttributeValues;
use App\Models\Deposit;
use App\Models\MiningServicesBuyHistory;
use App\Models\Setting;
use App\Models\TransactionHistory;
use App\Models\WalletAddress;
use App\Models\Withdraw;
use App\Models\addWithDrawMethod;
use App\Models\ApiConfig;
use App\Models\Currency;
use App\Models\GamePlatform;
use App\Models\GamePlatformOnly;
use App\Models\LoanPayHistory;
use App\Models\SendReceived;
use App\Models\UserPaymentAddress;
use App\Models\WithdrawMethod;
use Illuminate\Support\Str;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\JsonResponse;
use Session;
use Carbon\Carbon;
use DB;
use Faker\Core\Number;
use PDO;
use PhpOffice\PhpSpreadsheet\Calculation\DateTimeExcel\Current;
use PhpParser\Node\Stmt\TryCatch;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Balance\BalanceController;


class WithdrawalController extends Controller
{
    protected $userid;
    public function __construct()
    {
        $this->middleware('auth:api');
        $id = auth('api')->user();
        if (!empty($id)) {
            $user = User::find($id->id);
            $this->userid = $user->id;
        }
    }


    public function updateWithDrawRequest(Request $request)
    {

        try {
            $validator = Validator::make($request->all(), [
                'remarks'             => 'required',
                'status'              => 'required|numeric',
                'id'                  => 'required',
            ]);
            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            $deposit = Withdraw::find($request->id);
            $deposit->update([
                'remarks'           => $request->remarks,
                'status'            => 2, //$request->status,
                'approved_by'       => $this->userid
            ]);
            return response()->json(['message' => 'Withdraw updated successfully'], 200);
        } catch (QueryException $e) {
            // Log the error or handle it as needed
            return response()->json(['error' => 'Database error occurred.'], 500);
        } catch (\Exception $e) {
            // Handle other exceptions
            return response()->json(['error' => 'An unexpected error occurred.'], 500);
        }
    }

    public function generateRandomString($length = 16)
    {
        return substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyz', $length)), 0, $length);
    }

    public function generateSignature($random, $sn, $secretKey)
    {
        return md5($random . $sn . $secretKey);
    }



    public function generateOrderNumber()
    {
        // Generates 16 random bytes and converts them to a 32-character hexadecimal string
        return bin2hex(random_bytes(16));
    }





    public function walletAddressUpdate(Request $request)
    {

        //dd($request->all());
        $id        = $request->slug;
        $waAddress = $request->walletName;
        $checkpost = Deposit::where('id', $id)->where('status', 0)->first();
        if ($checkpost) {
            $checkpost->to_crypto_wallet_address = $waAddress;
            $checkpost->save();
            return response()->json([
                'message' => 'updated successfully wallet address.' . $waAddress,
            ], 200);
        } else {
            return response()->json([
                'message' => 'Deposit not found or status is not valid.',
            ], 404);
        }
    }



    public function sendWithdrawalRequest(Request $request)
    {

        // dd($request->all());
        // try {
        $validator = Validator::make(

            $request->all(),
            [
                'withdrawal_amount' => 'required',
                'wallet_address'    => 'required',
            ],
            [
                'withdrawal_amount.required'        => 'The amount field is required. Please enter a valid amount.',
                'wallet_address.required'     => 'Please select a wallet_address.',
            ]
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $apiBalanceController = app('App\Http\Controllers\Balance\BalanceController')->getCurrentBalance();
        $responseArray        = $apiBalanceController->getData(true);
        $currentBalance       = !empty($responseArray['balance']) ? $responseArray['balance'] : 0;
        //dd($currentBalance);
        // Check if balance exists in the response

        if ($request->withdrawal_amount > $currentBalance) {
            return response()->json(['errors' => ['withdrawal_amount' => ["Invalid Request. Your available balance is: {$currentBalance} USDT"]]], 422);
        }

        // $chkuserWalletAdd =  User::where('id', $this->userid)->first();
        //$wallAddres       = !empty($chkuserWalletAdd) ? $chkuserWalletAdd->withdrwal_wallet_address : "";

        $uniqueID = 'W:' . $this->generateUnique4DigitNumber();
        $data = array(
            'withdrawID'        => $uniqueID,
            'depscription'      => $uniqueID,
            'withdrawal_amount' => $request->withdrawal_amount,
            'payment_method'    => "TRC20",
            'wallet_address'    => $request->wallet_address,
            'status'            => 0,
            'user_id'           => $this->userid
        );
        $last_Id = Withdraw::insertGetId($data);
        return response()->json([
            'success' => true,
            'message' => 'Withdrawal request has been successfully send.',
            'data'    => $data
        ]);
    }

    function generateUnique4DigitNumber($existingNumbers = [])
    {
        do {
            $uniqueNumber = str_pad(mt_rand(0, 9999), 4, '0', STR_PAD_LEFT);
        } while (in_array($uniqueNumber, $existingNumbers));

        return md5($uniqueNumber);
    }




    public function withdrawalHistoryReport(Request $request)
    {
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 100000);

        $searchUserEmail    = $request->searchUserEmail;
        $searchTranId       = $request->searchOrderId;
        $sDate              = $request->filterFrmDate;
        $eDate              = $request->filterToDate;
        $searchusername     = $request->searchEmail;
        $selectedStatus     = $request->selectedFilter;

        $startDate = Carbon::parse($sDate)->startOfDay();
        $endDate = Carbon::parse($eDate)->endOfDay();

        // dd($selectedFilter);
        $query = Withdraw::orderBy('withdraw.id', 'desc')
            ->join('users', 'withdraw.user_id', '=', 'users.id')
            ->select(
                'withdraw.*',
                'users.name',
                'users.username',
                'users.telegram',
                'users.phone_number',
                'users.whtsapp',
                'users.email'
            );

        if ($searchusername !== null) {
            $query->where('users.username', 'like', '%' . $searchusername . '%');
            //$query->where('users.email', $searchUserEmail);
        }

        if ($searchTranId !== null) {
            $query->where('withdraw.withdrawID', 'like', '%' . $searchTranId . '%');
            //$query->where('users.email', $searchOrderId);
        }

        if ($selectedStatus !== null) {
            if ($selectedStatus == 5) {
                $query->whereIn('withdraw.status', [0, 1, 2]);
            } else {
                $query->where('withdraw.status', $selectedStatus);
            }
        }

        // Apply date range filtering if start and end dates are provided
        if ($startDate !== null && $endDate !== null) {
            $query->whereBetween('withdraw.created_at', [$startDate, $endDate]);
        }

        // $query->where('users.role_id', 2);
        $results = $query->get();
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);
        $modifiedCollection = $results->map(function ($item) {

            $statusLabels = [
                1 => 'Active',
                0 => 'Pending',
                2 => 'Reject',
            ];


            return [
                'id'                    => $item->id,
                'withdrawID'            => $item->withdrawID,
                'withdrawa_date'        => date("Y-M-d", strtotime($item->created_at)),
                'withdrawal_amount'     => number_format($item->withdrawal_amount, 2),
                'wallet_address'        => $item->wallet_address,
                'receivable_amount'     => $item->receivable_amount,
                'gamePltName'           => !empty($item->gamePltName) ? $item->gamePltName : "",
                'currencyName'          => !empty($item->currencyName) ? $item->currencyName : "",
                'status'                => $item->status,
                'username'              => $item->username,
                'orderId'               => $item->orderId,
                'email'                 => $item->email,
                'statusName'            => $statusLabels[$item->status] ?? 'Unknown'
            ];
        });

        // Return the modified collection along with pagination metadata
        return response()->json([
            'data' => $modifiedCollection,
            'current_page' => $paginator->currentPage(),
            'total_pages' => $paginator->lastPage(),
            'total_records' => $paginator->total(),
        ], 200);
    }

    public function withdrawalCancel($id)
    {
        $withdraw = Withdraw::find($id);
        $withdraw->status = 2;
        $withdraw->save();
        return response()->json([
            'success' => true,
            'message' => 'Withdrawal request has been successfully cancelled.',
            'data'    => $withdraw
        ]);
    }



    public function withdrawalRequeseCancel(Request $request)
    {

        $id      = $request->id;
        $remarks = $request->remarks;

        $withdraw = Withdraw::find($id);
        $withdraw->status  = 2;
        $withdraw->remarks = $remarks;
        $withdraw->save();
        return response()->json([
            'success' => true,
            'message' => 'Withdrawal request has been successfully cancelled.',
            'data'    => $withdraw
        ]);
    }


    public function withdrawrow($id)
    {
        try {
            $user = withdraw::where('withdraw.id', $id)
                ->select('users.username', 'users.email', 'users.withdrwal_wallet_address', 'withdraw.*')
                ->leftJoin('users', 'withdraw.user_id', '=', 'users.id')
                ->first();
            $user['createdate']       = date("d-m-Y", strtotime($user->created_at));
            $user['withdraw_amount'] = number_format($user->withdraw_amount, 2);
            return response()->json($user);
        } catch (\Exception $e) {
            echo "Error: " . $e->getMessage();
            $error = $e->getMessage();
            return response()->json($error);
        }
    }


    public function approvedWithdrawRequest(Request $request)
    {

        $validator = Validator::make(
            $request->all(),
            [
                'id'                => 'required',
                'withdrawal_amount' => 'required',
            ],
            [
                'id.required'                => 'The id field is required.',
                'withdrawal_amount.required' => 'The amount field is required',

            ]
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        //Update our db
        $withdrawUpdate = Withdraw::find($request->id);
        $withdrawUpdate->update([
            'status'           => 1,
        ]);


        return response()->json("Successfully update", 200);
    }

    // Function to log response
    function logResponse($apiUrl, $headers, $data, $httpCode, $response, $err = null)
    {
        $logFile = 'api_response_log.txt';  // Log file name
        $logData = "Date: " . date('Y-m-d H:i:s') . PHP_EOL;
        $logData .= "URL: $apiUrl" . PHP_EOL;
        $logData .= "Headers: " . print_r($headers, true) . PHP_EOL;
        $logData .= "Payload: " . json_encode($data, JSON_PRETTY_PRINT) . PHP_EOL;
        $logData .= "HTTP Status Code: $httpCode" . PHP_EOL;

        if ($err) {
            $logData .= "cURL Error: $err" . PHP_EOL;
        } else {
            $logData .= "Response: " . $response . PHP_EOL;
        }

        $logData .= str_repeat("-", 80) . PHP_EOL;
        // Append log to file
        file_put_contents($logFile, $logData, FILE_APPEND);
        return $logData;
    }

    public function userWithdrawalHistory(Request $request)
    {
        $sDate              = $request->filterFrmDate;
        $eDate              = $request->filterToDate;
        $searchTranId       = $request->searchtxt;
        $selectedStatus     = $request->selectedFilter;
        $startDate          = Carbon::parse($sDate)->startOfDay();
        $endDate            = Carbon::parse($eDate)->endOfDay();

        // dd($selectedFilter);
        $query = Withdraw::orderBy('withdraw.id', 'desc')
            ->join('users', 'withdraw.user_id', '=', 'users.id')
            ->select(
                'withdraw.*',
                'users.name',
                'users.username',
                'users.telegram',
                'users.phone_number',
                'users.whtsapp',
                'users.email'
            );
        if ($searchTranId !== null) {
            $query->where('withdraw.withdrawID', 'like', '%' . $searchTranId . '%');
            //$query->where('users.email', $searchOrderId);
        }
        if ($selectedStatus !== null) {
            if ($selectedStatus == 5) {
                $query->whereIn('withdraw.status', [0, 1, 2]);
            } else {
                $query->where('withdraw.status', $selectedStatus);
            }
        }
        // Apply date range filtering if start and end dates are provided
        if ($startDate !== null && $endDate !== null) {
            $query->whereBetween('withdraw.created_at', [$startDate, $endDate]);
        }

        // $query->where('users.role_id', 2);
        $results = $query->get();
        $modifiedCollection = $results->map(function ($item) {

            $statusLabels = [
                1 => 'Active',
                0 => 'Pending',
                2 => 'Reject',
            ];

            return [
                'id'                    => $item->id,
                'withdrawID'            => $item->withdrawID,
                'withdrawa_date'        => date("Y-M-d", strtotime($item->created_at)),
                'withdrawal_amount'     => number_format($item->withdrawal_amount, 2),
                'wallet_address'        => $item->wallet_address,
                'receivable_amount'     => $item->receivable_amount,
                'gamePltName'           => !empty($item->gamePltName) ? $item->gamePltName : "",
                'currencyName'          => !empty($item->currencyName) ? $item->currencyName : "",
                'status'                => $item->status,
                'username'              => $item->username,
                'orderId'               => $item->orderId,
                'email'                 => $item->email,
                'statusName'            => $statusLabels[$item->status] ?? 'Unknown'
            ];
        });

        // Return the modified collection along with pagination metadata
        return response()->json([
            'data' => $modifiedCollection,
        ], 200);
    }

    public function checkwalletAddressAllHistory(Request $request)
    {



        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 100000);

        $searchUserEmail    = $request->searchUserEmail;
        $searchTranId       = $request->searchOrderId;
        $sDate              = $request->filterFrmDate;
        $eDate              = $request->filterToDate;
        $searchusername     = $request->searchEmail;
        $selectedStatus     = $request->selectedFilter;

        $startDate = Carbon::parse($sDate)->startOfDay();
        $endDate = Carbon::parse($eDate)->endOfDay();

        // dd($selectedFilter);
        $query = UserPaymentAddress::orderBy('add_user_payment_address.id', 'desc')
            ->join('users', 'add_user_payment_address.user_id', '=', 'users.id')
            ->select(
                'add_user_payment_address.*',
                'add_user_payment_address.name as coinName',
                'users.name',
                'users.username',
                'users.email'
            );

        if ($searchusername !== null) {
            $query->where('users.username', 'like', '%' . $searchusername . '%');
            //$query->where('users.email', $searchUserEmail);
        }

        // $query->where('users.role_id', 2);
        $results = $query->get();
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);
        $modifiedCollection = $results->map(function ($item) {

            $statusLabels = [
                1 => 'Active',
                0 => 'Pending',
                2 => 'Reject',
            ];


            return [
                'id'                    => $item->id,
                'created_at'            => date("Y-M-d", strtotime($item->created_at)),
                'coinName'              => $item->coinName,
                'wallet_address'        => $item->wallet_address,
                'status'                => $item->status,
                'username'              => $item->username,
                'email'                 => $item->email,
                'statusName'            => $statusLabels[$item->status] ?? 'Unknown'
            ];
        });

        // Return the modified collection along with pagination metadata
        return response()->json([
            'data' => $modifiedCollection,
            'current_page' => $paginator->currentPage(),
            'total_pages' => $paginator->lastPage(),
            'total_records' => $paginator->total(),
        ], 200);
    }
}
