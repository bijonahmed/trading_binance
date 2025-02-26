<?php

namespace App\Http\Controllers\Balance;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Trading\TradingController;
use App\Models\ApiConfig;
use App\Models\BuyToken;
use App\Models\Community;
use App\Models\Currency;
use App\Models\Deposit;
use App\Models\ExpenseHistory;
use App\Models\GamePlatformOnly;
use App\Models\ManualAdjustment;
use App\Models\ManualAdjustmentDelete;
use App\Models\MiningServicesBuyHistory;
use App\Models\MystoreHistory;
use App\Models\Order;
use Illuminate\Http\Request;
use Auth;
use Validator;
use Helper;
use App\Models\User;
use App\Models\Profile;
use App\Models\RuleModel;
use App\Models\SendReceived;
use App\Models\TransactionHistory;
use App\Models\WalletAddress;
use App\Models\kyc;
use App\Models\LoanPayHistory;
use App\Models\MiningBalanceSum;
use App\Models\Notification;
use App\Models\Setting;
use App\Models\SwapHistory;
use App\Models\Trade;
use App\Models\UserBotHistory;
use App\Models\UserMiningHistory;
use App\Models\UserPaymentAddress;
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

        $deposit         = Deposit::where('user_id', $this->userid)->where('status', 1)->sum('receivable_amount');
        $withdraw_amount = Withdraw::where('user_id', $this->userid)->where('status', 1)->sum('withdrawal_amount');
        $balance         = $deposit - $withdraw_amount;

        return response()->json([
            'balance' => $balance,
        ]);
    }
}
