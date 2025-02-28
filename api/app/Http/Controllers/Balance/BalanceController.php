<?php

namespace App\Http\Controllers\Balance;

use App\Http\Controllers\Controller;
use App\Models\Deposit;
use App\Models\Trade;
use Illuminate\Http\Request;
use Auth;
use Validator;
use Helper;
use App\Models\User;
use App\Models\Withdraw;
use Illuminate\Support\Str;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use DB;
use File;
use PhpParser\Node\Stmt\TryCatch;
use function Ramsey\Uuid\v1;
use Illuminate\Http\JsonResponse;
use PDO;

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

        $deposit                = Deposit::where('user_id', $this->userid)->where('status', 1)->sum('receivable_amount');
        $withdraw_amount        = Withdraw::where('user_id', $this->userid)->where('status', 1)->sum('withdrawal_amount');
        $tradeAmountRuning      = Trade::where('user_id', $this->userid)->where('status', 0)->sum('trade_amount'); //Runing Trade
        $tradeAmountComplete    = Trade::where('user_id', $this->userid)->where('status', 1)->sum('trade_amount'); //Complete Trade 
        $tradeLoss              = Trade::where('user_id', $this->userid)->where('action', 'LOSS')->sum('trade_amount'); //Trade Loss
        $tradePercentageResult  = Trade::where('user_id', $this->userid)->where('action', 'WIN')->sum('percentage_result'); //Trade Loss
      
        $balance    = $deposit - $withdraw_amount - $tradeAmountRuning + $tradeAmountComplete - $tradeLoss + $tradePercentageResult;

        return response()->json([
            'balance' => number_format($balance,2),
        ]);
    }
}
