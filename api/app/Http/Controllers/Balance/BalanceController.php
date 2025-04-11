<?php

namespace App\Http\Controllers\Balance;

use App\Http\Controllers\Controller;
use App\Models\Deposit;
use App\Models\ManualAdjustment;
use App\Models\Trade;
use App\Models\User;
use App\Models\Withdraw;
use App\Rules\MatchOldPassword;
use Auth;
use DB;
use File;
use function Ramsey\Uuid\v1;
use Helper;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use PDO;
use PhpParser\Node\Stmt\TryCatch;
use Validator;

class BalanceController extends Controller
{
    protected $frontend_url;
    protected $userid;
    protected $email;
    public function __construct(Request $request)
    {
        $this->middleware('auth:api');
        $id = auth('api')->user();
        if (!empty($id)) {
            $user = User::find($id->id);
            $this->userid = $user->id;
            $this->email = $user->email;
        }
    }


    public function checkBalanceAdmin($id) {}


    public function getCurrentBalance()
    {

        $debitAmount             = ManualAdjustment::where('user_id', $this->userid)->where('adjustment_type', 1)->sum('adjustment_amount'); 
        $creditAmount            = ManualAdjustment::where('user_id', $this->userid)->where('adjustment_type', 2)->sum('adjustment_amount'); 

        $deposit                = Deposit::where('user_id', $this->userid)->where('status', 1)->sum('receivable_amount');
        $withdraw_amount        = Withdraw::where('user_id', $this->userid)->whereIn('status', [0,1])->sum('withdrawal_amount');

        $tradeAmount            = Trade::where('user_id', $this->userid)->sum('trade_amount'); //Runing Trade
        $tradeAmountComplete    = Trade::where('user_id', $this->userid)->where('status', 1)->sum('trade_amount'); //Complete Trade 

        $tradeLoss              = Trade::where('user_id', $this->userid)->where('action', 'LOSS')->sum('trade_amount'); //Trade Loss

        $tradePercentageResult  = Trade::where('user_id', $this->userid)->where('action', 'WIN')->sum('percentage_result'); //Trade Loss
        //$balance                = $debitAmount + $deposit - $withdraw_amount - $tradeAmount + $tradeAmountComplete - $tradeLoss + $tradePercentageResult;
        $balance                = $deposit - $withdraw_amount - $tradeAmount + $tradeAmountComplete - $tradeLoss + $tradePercentageResult + $debitAmount - $creditAmount;
        /*
        echo "deposit: $deposit - withdraw_amount: $withdraw_amount - tradeAmount: $tradeAmountComplete + 
        tradeAmountComplete: $tradeAmountComplete - tradeLoss: $tradeLoss + tradePercentageResult: $tradePercentageResult----[Balance : $balance]";
        exit; 
        */
        return response()->json([
            'balance' => number_format($balance,2),
        ]);
    }

    public function getCurrentBalanceAdmin($userId)
    {

        $debitAmount             = ManualAdjustment::where('user_id', $userId)->where('adjustment_type', 1)->sum('adjustment_amount'); 
        $creditAmount            = ManualAdjustment::where('user_id', $userId)->where('adjustment_type', 2)->sum('adjustment_amount'); 

        $deposit                = Deposit::where('user_id', $userId)->where('status', 1)->sum('receivable_amount');
        $withdraw_amount        = Withdraw::where('user_id', $userId)->whereIn('status', [0,1])->sum('withdrawal_amount');

        $tradeAmount            = Trade::where('user_id', $userId)->sum('trade_amount'); //Runing Trade
        $tradeAmountComplete    = Trade::where('user_id', $userId)->where('status', 1)->sum('trade_amount'); //Complete Trade 

        $tradeLoss              = Trade::where('user_id', $userId)->where('action', 'LOSS')->sum('trade_amount'); //Trade Loss

        $tradePercentageResult  = Trade::where('user_id', $userId)->where('action', 'WIN')->sum('percentage_result'); //Trade Loss
        //$balance                = $debitAmount + $deposit - $withdraw_amount - $tradeAmount + $tradeAmountComplete - $tradeLoss + $tradePercentageResult;
        $balance                = $deposit - $withdraw_amount - $tradeAmount + $tradeAmountComplete - $tradeLoss + $tradePercentageResult + $debitAmount - $creditAmount;
        /*
        echo "deposit: $deposit - withdraw_amount: $withdraw_amount - tradeAmount: $tradeAmountComplete + 
        tradeAmountComplete: $tradeAmountComplete - tradeLoss: $tradeLoss + tradePercentageResult: $tradePercentageResult----[Balance : $balance]";
        exit; 
        */
        return response()->json([
            'balance' => number_format($balance,2),
        ]);
    }
}
