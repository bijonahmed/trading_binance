<?php

namespace App\Http\Controllers\Payment;

use App\Http\Controllers\Controller;
use App\Models\MystoreHistory;
use App\Models\Order;
use Illuminate\Http\Request;
use App\Models\Product;
use Illuminate\Support\Facades\Crypt;
use App\Models\ProductCategory;
use App\Models\User;
use App\Jobs\ProcessExcelUpload;
use App\Models\Customer;
use App\Models\Deposit;
use App\Models\OrderHistory;
use App\Models\Payment;
use App\Models\Setting;
use App\Models\UserPaymentAddress;
use Illuminate\Support\Facades\Session;
use PayPal\Api\Amount;
use Srmklive\PayPal\Services\PayPal as PayPalClient;
//use PayPal\Api\Payment;
use Validator;
use Carbon\Carbon;
use PhpOffice\PhpSpreadsheet\IOFactory;
use Illuminate\Support\Facades\Redirect;
use PayPal\Api\Order as ApiOrder;
use Illuminate\Support\Facades\Log;


class PaymentController extends Controller
{

    private static $storedData = [];
    protected $frontend_url;


    protected $userid;
    protected $api_key;
    protected $password;
    protected $wallet_url;
    protected $domain;
    protected $deposit_request_url;
    protected $checkMerchent;
    protected $username;
    public function __construct()
    {
        $this->middleware('auth:api');
        $id = auth('api')->user();
        if (!empty($id)) {
            $user = User::find($id->id);
            $this->userid              = $user->id;
            $this->username            = $user->username;
            $this->api_key             = "TQUiTZzqypMpwSNTaKS1kye2p1MGd4tNvK";
            $this->password            = "LRWwU5D6womf";
            $this->domain              = "https://api.cryptopaymentchecker.futuregenit.com";
            $this->wallet_url          = "/api/address/getwalleteAddress";
            $this->checkMerchent       = $this->domain . "/api/address/checkMerchentDetails";
            $this->deposit_request_url = $this->domain . "/api/address/depositRequest";
        }
    }

    public function sendPaymentMethodRequest(Request $request)
    {

        // Check if the incoming request is JSON
        $validatedData = $request->validate([
            'walletAddress' => 'required',
            'currency'      => 'required',
        ]);

        $walletAddress = $validatedData['walletAddress'];
        $check         = UserPaymentAddress::where('wallet_address', $walletAddress)->first();
        if (empty($check)) {
            // Insert the data into the Deposit model
            $resData = UserPaymentAddress::create([
                'wallet_address'        => $validatedData['walletAddress'],
                'name'                  => $validatedData['currency'],
                'user_id'               => $this->userid,
                'status'                => 1,
            ]);

            // Respond with a success message
            return response()->json([
                'message' => 'Wallet Address successfully created',
                'data' => $resData
            ], 200);
        }
    }

    
    public function checkwalletAddress(Request $request)
    {
        $responseData  = Setting::where('id', 1)->first();
        $walletAddress = !empty($responseData->crypto_wallet_address) ? $responseData->crypto_wallet_address : "";
        $data['data']     =  $walletAddress;
        return response()->json($data, 200);
    }

  public function checkwalletAddressAllHistory(Request $request)
    {
        $responseData  = Setting::where('id', 1)->first();
        $walletAddress = !empty($responseData->crypto_wallet_address) ? $responseData->crypto_wallet_address : "";
        $data['data']     =  $walletAddress;
        return response()->json($data, 200);
    }


    
    public function walltAddressList(Request $request)
    {
        $responseData = UserPaymentAddress::where('status', 1)->get();
        $data['data']     =  $responseData;
        return response()->json($data, 200);
    }

    function generateUniqueRandomNumber($length = 5)
    {
        $randomString = substr(md5(uniqid(mt_rand(), true)), 0, $length);

        return $randomString;
    }
}
