<?php

namespace App\Http\Controllers\Deposits;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Auth;
use Validator;
use Helper;
use App\Models\Holiday;
use App\Models\User;
use App\Models\ProductAttributeValue;
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

class DepositController extends Controller
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

    public function getCurrentBalance()
    {
        $depositAmt = Deposit::where('status', 1)->sum('deposit_amount');
        $data['currentBalance'] = $depositAmt;
        return response()->json([
            'data' => $data,
        ], 200);
    }


    public function currencyList()
    {

        $data = Currency::where('status', 1)->get();
        return response()->json([
            'data' => $data,
        ], 200);
    }


    public function depositHistoryReportAdmin(Request $request)
    {

        //dd($request->all());

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        $searchTranId       = $request->searchOrderId;
        $sDate              = $request->filterFrmDate;
        $eDate              = $request->filterToDate;
        $searchusername     = $request->searchEmail;
        $selectedStatus     = $request->selectedFilter;
        $startDate = Carbon::parse($sDate)->startOfDay();
        $endDate = Carbon::parse($eDate)->endOfDay();

        //echo "$startDate----$endDate";exit;

        // dd($selectedFilter);
        $query = Deposit::orderBy('deposit.id', 'desc')
            ->join('users', 'users.id', '=', 'deposit.user_id')  // Join users table
            ->select(
                'deposit.*',
                'users.username as username',
                'users.telegram',
                'users.phone_number',
                'users.whtsapp',
                'users.email'
            );

        // ->select('deposit.*', 'users.name as username', 'users.telegram', 'users.phone_number', 'users.whtsapp', 'users.email', 'gameplatform.name as gamePltName', 'currency.name as currencyName');

        if ($searchusername !== null && $searchusername !== '') {
            $query->where('users.username', 'like', '%' . $searchusername . '%');
        }

        if ($searchTranId !== null) {
            $query->where('deposit.depositID', 'like', '%' . $searchTranId . '%');
            //$query->where('users.email', $searchOrderId);
        }

        if ($selectedStatus !== null && $selectedStatus !== '') {
            $selectedStatus = (int) $selectedStatus;
            $query->where('deposit.status', $selectedStatus);
        }


        // Ensure the dates include the time if needed
        if ($startDate !== null && $endDate !== null) {
            // Apply the date filter
            $query->whereBetween('deposit.created_at', [$startDate, $endDate]);
        }

        // $query->where('users.role_id', 2);
        // $results = $query->get();
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        // Map over the paginated results instead of fetching all
        $modifiedCollection = $paginator->map(function ($item) {
            $userrow      = User::where('id', $item->user_id)->first();
            $pltrow       = GamePlatformOnly::where('id', $item->gaming_pltform_id)->first();
            $currencyrow  = Currency::where('id', $item->currency_id)->first();

            $statusLabels = [
                1 => 'Active',
                0 => 'Pending',
                2 => 'Reject',
            ];

            return [
                'id'                => $item->id,
                'depositID'         => $item->depositID,
                'deposit_date'      => date("d-M-Y", strtotime($item->created_at)),
                'deposit_amount'    => number_format($item->deposit_amount, 2),
                'wallet_address'    => $item->wallet_address,
                'receivable_amount' => $item->receivable_amount,
                'toAddressWallet'   => $item->to_crypto_wallet_address,
                'username'          => $userrow->username ?? "",
                'payment_method'    => $item->payment_method ?? "",
                'email'             => $userrow->email ?? "",
                'gamePltName'       => $pltrow->name ?? "",
                'currencyName'      => $currencyrow->name ?? "",
                'status'            => $item->status,
                'orderId'           => $item->orderId,
                'statusName'        => $statusLabels[$item->status] ?? 'Unknown'
            ];
        });

        // Return the modified collection along with pagination metadata
        return response()->json([
            'data'          => $modifiedCollection,
            'current_page'  => $paginator->currentPage(),
            'total_pages'   => $paginator->lastPage(),
            'total_records' => $paginator->total(),
        ], 200);
    }




    public function depositHistoryReport(Request $request)
    {
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 100000);

        $searchUserEmail    = $request->searchUserEmail;
        $searchTranId       = $request->searchOrderId;
        $sDate              = $request->frm;
        $eDate              = $request->to;
        $selectedStatus     = $request->status;
        $startDate = Carbon::parse($sDate)->startOfDay();
        $endDate = Carbon::parse($eDate)->endOfDay();

        // dd($selectedFilter);
        $query = Deposit::orderBy('deposit.id', 'desc')
            ->join('users', 'deposit.user_id', '=', 'users.id')
            ->join('gameplatform', 'gameplatform.id', '=', 'deposit.gaming_pltform_id')
            ->join('currency', 'currency.id', '=', 'deposit.currency_id')
            ->select('deposit.*', 'users.name as username', 'users.telegram', 'users.phone_number', 'users.whtsapp', 'users.email', 'gameplatform.name as gamePltName', 'currency.name as currencyName');

        if ($searchUserEmail !== null) {
            $query->where('users.email', 'like', '%' . $searchUserEmail . '%');
            //$query->where('users.email', $searchUserEmail);
        }

        if ($searchTranId !== null) {
            $query->where('deposit.depositID', 'like', '%' . $searchTranId . '%');
            //$query->where('users.email', $searchOrderId);
        }

        if ($selectedStatus !== null) {
            $query->where('deposit.status', $selectedStatus);
        }

        // Apply date range filtering if start and end dates are provided
        if ($startDate !== null && $endDate !== null) {
            $query->whereBetween('deposit.created_at', [$startDate, $endDate]);
        }

        // $query->where('users.role_id', 2);
        $results = $query->get();
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);
        $modifiedCollection = $results->map(function ($item) {

            return [
                'id'                => $item->id,
                'depositID'         => $item->depositID,
                'deposit_date'      => date("Y-M-d", strtotime($item->created_at)),
                'deposit_amount'    => number_format($item->deposit_amount, 2),
                'wallet_address'    => $item->wallet_address,
                'receivable_amount' => $item->receivable_amount,
                'toAddressWallet'   => $item->to_crypto_wallet_address,
                'gamePltName'       => !empty($item->gamePltName) ? $item->gamePltName : "",
                'currencyName'      => !empty($item->currencyName) ? $item->currencyName : "",
                'status'            => $item->status
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

    public function filterRechargeList(Request $request)
    {

        // Get search query from the request
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        $searchUserEmail    = $request->searchUserEmail;
        $searchTranId       = $request->searchOrderId;
        $sDate              = $request->startDate;
        $eDate              = $request->endDate;
        $selectedStatus     = $request->selectedStatus;
        $startDate = Carbon::parse($sDate)->startOfDay();
        $endDate = Carbon::parse($eDate)->endOfDay();

        // dd($selectedFilter);
        $query = Deposit::orderBy('deposit.id', 'desc')
            ->join('users', 'deposit.user_id', '=', 'users.id')
            ->select('deposit.*', 'users.name as username', 'users.telegram', 'users.phone_number', 'users.whtsapp', 'users.email');

        if ($searchUserEmail !== null) {
            $query->where('users.email', 'like', '%' . $searchUserEmail . '%');
            //$query->where('users.email', $searchUserEmail);
        }

        if ($searchTranId !== null) {
            $query->where('deposit.depositID', 'like', '%' . $searchTranId . '%');
            //$query->where('users.email', $searchOrderId);
        }

        if ($selectedStatus !== null) {
            $query->where('deposit.status', $selectedStatus);
        }

        // Apply date range filtering if start and end dates are provided
        if ($startDate !== null && $endDate !== null) {
            $query->whereBetween('deposit.created_at', [$startDate, $endDate]);
        }

        // $query->where('users.role_id', 2);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);
        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $checkStatus    = $item->status == 1 ? 'SUCCESS' : 'UNPAID';
            $telegram       = !empty($item->telegram) ? $item->telegram : "None";
            $phone          = !empty($item->phone_number) ? $item->phone_number : "";
            $whtsapp        = !empty($item->whtsapp) ? $item->whtsapp : "None";

            return [
                'id'            => $item->id,
                'depositID'     => $item->depositID,
                'userInfo_1'    => $item->username,
                'userInfo_2'    => $phone,
                'userInfo_3'    => $item->email,
                'userInfo_4'    => $telegram,
                'deposit_date'  => date("Y-M-d", strtotime($item->created_at)),
                'deposit_amount' => $item->deposit_amount,
                'wallet_address' => $item->wallet_address,
                'receivable_amount' => $item->receivable_amount,
                'depscription'  => $item->depscription,
                'status'        => $checkStatus,
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

    public function addWithDrawMethod(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'name'                  => 'required',
                'account_number'        => 'required',
            ]);
            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            $data = array(
                'name'           => $request->name,
                'account_number' => $request->account_number,
                'user_id'        => $this->userid
            );
            WithdrawMethod::insertGetId($data);
            /////addWithDrawMethod

            return response()->json(['message' => 'method add successfully'], 200);
        } catch (QueryException $e) {
            // Log the error or handle it as needed
            return response()->json(['error' => 'Database error occurred.'], 500);
        } catch (\Exception $e) {
            // Handle other exceptions
            return response()->json(['error' => 'An unexpected error occurred.'], 500);
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



    public function checkQuota($username, $platType, $currency)
    {

        $api_config = ApiConfig::where('id', 3)->first(); //For  Merchant quota
        // Configuration
        $apiUrl     = "{$api_config->api_url}"; //"https://ap.api-bet.net/api/server/quota";
        $sn         = "{$api_config->sn}"; //"guw"; // Replace with your SN
        $secretKey  = "{$api_config->key}"; //"2SW80tB9C22800TrO64f9HcA761JR299"; // Replace with your secret key

        // Input Data
        $playerId = "{$username}"; //"test01";
        $platType = "{$platType}"; //"ag";
        $currency = "{$currency}"; //"INR";
        //  $gameType = 2; // Adding gameType parameter

        // Generate headers
        $random = $this->generateRandomString();
        $signature = $this->generateSignature($random, $sn, $secretKey);

        // Prepare the request payload
        $data = [
            // "platType" => $platType,
            // "playerId" => $playerId,
            "currency" => $currency,

        ];

        $headers = [
            "Content-Type: application/json",
            "random: $random",
            "sign: $signature",
            "sn: $sn",
        ];

        // Initialize cURL
        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_URL => $apiUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => $headers,
        ]);

        $response = curl_exec($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $err = curl_error($curl);
        curl_close($curl);
        // Handle the response
        // if ($err) {
        //     echo "cURL Error: " . $err;
        // } else {
        //     echo "<h3>Request Details</h3>";
        //     echo "<p>URL: $apiUrl</p>";
        //     echo "<p>Headers: <pre>" . print_r($headers, true) . "</pre></p>";
        //     echo "<p>Payload: <pre>" . json_encode($data, JSON_PRETTY_PRINT) . "</pre></p>";
        //     echo "<h3>Response</h3>";
        //     echo "<p>HTTP Status Code: $httpCode</p>";
        //     echo "<pre>" . htmlspecialchars($response) . "</pre>";
        // }

        $responseData = json_decode($response, true);
        $resp = [
            'balance' => 0,
            'error' => false,
            'msg' => '',
        ];
        if ($responseData && isset($responseData['data'][$currency])) {
            // Display the value for INR
            $resp['balance'] = $responseData['data'][$currency];
        }
        return $resp;
    }


    public function checktransferBalance($username, $platType, $currency, $depositAmount, $orderId)
    {

        $api_config = ApiConfig::where('id', 2)->first(); //For Credit Transfer 
        // Configuration
        $apiUrl     = "{$api_config->api_url}"; //"https://ap.api-bet.net/api/server/transfer";
        $sn         = "{$api_config->sn}"; //"guw"; // Replace with your SN
        $secretKey  = "{$api_config->key}"; //"2SW80tB9C22800TrO64f9HcA761JR299"; // Replace with your secret key

        // Input Data
        $playerId = "{$username}"; //"test01";
        $platType = "{$platType}"; //"ag";
        $currency = "{$currency}"; //"CNY";
        $type     = 1; //Conversion type, 1: transfer in, 2: transfer out
        $amount   = "{$depositAmount}"; //10;
        $orderId  = "{$orderId}"; //"97860a6f6eaacc7e256a0a1371b67c16";
        //$gameType = 2; // Adding gameType parameter

        // Generate headers
        $random    = $this->generateRandomString();
        $signature = $this->generateSignature($random, $sn, $secretKey);

        // Prepare the request payload
        $data = [
            "playerId" => $playerId,
            "platType" => $platType,
            "currency" => $currency,
            "type"     => $type,
            "amount"   => $amount,
            "orderId"   => $orderId

        ];

        $headers = [
            "Content-Type: application/json",
            "random: $random",
            "sign: $signature",
            "sn: $sn",
        ];

        // Initialize cURL
        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_URL => $apiUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => $headers,
        ]);

        $response = curl_exec($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $err = curl_error($curl);

        curl_close($curl);
        $response = json_decode($response, true);

        return $response;
        /*
        // Handle the response
        if ($err) {
            echo "cURL Error: " . $err;
        } else {
            echo "<h3>Request Details</h3>";
            echo "<p>URL: $apiUrl</p>";
            echo "<p>Headers: <pre>" . print_r($headers, true) . "</pre></p>";
            echo "<p>Payload: <pre>" . json_encode($data, JSON_PRETTY_PRINT) . "</pre></p>";
            echo "<h3>Response</h3>";
            echo "<p>HTTP Status Code: $httpCode</p>";
            echo "<pre>" . htmlspecialchars($response) . "</pre>";
        }
          */
    }


    public function generateOrderNumber()
    {
        // Generates 16 random bytes and converts them to a 32-character hexadecimal string
        return bin2hex(random_bytes(16));
    }

    public function createPlayer($username, $platType, $currency)
    {

        $api_config = ApiConfig::where('id', 1)->first();
        // Configuration
        $apiUrl     = "{$api_config->api_url}"; //"https://ap.api-bet.net/api/server/create";
        $sn         = "{$api_config->sn}"; //"guw"; // Replace with your SN
        $secretKey  = "{$api_config->key}"; //"2SW80tB9C22800TrO64f9HcA761JR299"; // Replace with your secret key


        // Input Data
        $playerId  = "{$username}";
        $platType  = "{$platType}";
        $currency  = "{$currency}";
        $gameType  = 1; // Adding gameType parameter
        // Generate headers
        $random    = $this->generateRandomString();
        $signature = $this->generateSignature($random, $sn, $secretKey);
        // Prepare the request payload
        $data = [
            "platType" => $platType,
            "playerId" => $playerId,
            "currency" => $currency,
            "gameType" => $gameType,
        ];

        $headers = [
            "Content-Type: application/json",
            "random: $random",
            "sign: $signature",
            "sn: $sn",
        ];

        // Initialize cURL
        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_URL => $apiUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => $headers,
        ]);

        $response = curl_exec($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $err = curl_error($curl);

        curl_close($curl);
        $this->logResponse($apiUrl, $headers, $data, $httpCode, '', $err);
    }

    public function updateDepositRequest(Request $request)
    {
        // approved update 
        $validator = Validator::make($request->all(), [
            'receivable_amount'  => 'required|numeric',
            'status'             => 'required|numeric',
            'id'                 => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        //Update our db
        $deposit = Deposit::find($request->id);
        $deposit->update([
            'receivable_amount' => $request->receivable_amount,
            'status'            => 1,
            'approved_by'       => $this->userid
        ]);
        //Check NG Quota API
        //     $this->createPlayer($username, $platType, $currency);
        $resp = [
            'message' => 'Deposit updated successfully',
        ];

        return response()->json($resp, 200);
    }


    public function withdrawRequest(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'withdrawal_amount'  => 'required',
            'wallet_address'     => 'required',
            'withdrawal_pin'   => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = User::find($this->userid);
        // Check if the user exists
        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Check if the provided password matches the user's password
        if ($request->withdrawal_pin !== $user->new_pin) {
            return response()->json(['errors' => ['withdrawal_pin' => ['Incorrect PIN']]], 422);
        }


        $userid        = $this->userid;
        $depositAmount = Deposit::where('user_id', $userid)->select('deposit_amount')->where('status', 1)->sum('deposit_amount');
        $setting       = Setting::find(1);
        $walletInfo    = UserPaymentAddress::where('user_id', $userid)->first();

        if ($request->withdrawal_amount < $setting->minimum_withdrawal) {
            return response()->json(['errors' => ['error_minim_usdt' => ['Minimum USDT balance is ', $setting->minimum_withdrawal]]], 422);
        }

        if ($request->withdrawal_amount > $depositAmount) {
            return response()->json(['errors' => ['error_usdt' => ['You have no sufficiant USDT balance']]], 422);
        }


        $chkloanAmt     = LoanPayHistory::where('type', 1)->where('status', 0)->sum('amount');
        $loanAmount     = abs($chkloanAmt);

        $chkPayloanAmt  = LoanPayHistory::where('type', 2)->where('status', 1)->sum('amount');
        $loanPayAmount  = abs($chkPayloanAmt);

        $payResult = $loanAmount - $loanPayAmount;

        //dd($payResult);

        if ($payResult > 0) {
            return response()->json(['errors' => ['error_usdt' => ["Your pay amount must not be greater than the loan amount. Loan Amount is $payResult USDT"]]], 422);
        }

        $uniqueID = 'W.' . $this->generateUnique4DigitNumber();
        $data = array(
            'withdrawID'     => $uniqueID,
            'depscription'   => $uniqueID,
            'withdrawal_amount' => $request->withdrawal_amount,
            'wallet_address' => $walletInfo->wallet_address,
            'withdrawal_pin' => $request->withdrawal_pin,
            'status'         => 0,
            'payment_method' => 'TRX(TRC20)',
            'user_id'        => $this->userid
        );
        $last_Id = Withdraw::insertGetId($data);

        $tran['user_id']     = $this->userid;
        $tran['type']        = 2; //Withdraw
        $tran['last_Id']     = $last_Id;
        $tran['amount']      = $request->withdrawal_amount;
        $tran['description'] = 'Withdraw';
        TransactionHistory::insert($tran);

        return response()->json(['data' => 'Successfully send your request.'], 200);
    }


    public function checkRandomKey(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'slug'  => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $id = (int) $request->slug;
        $data = Deposit::where('id', $id)->where('status', 0)->first();
        if ($data) {
            return response()->json([
                'message' => 'fetech successfully.',
                'data' => $data
            ], 200);
        } else {
            return response()->json([
                'message' => 'Deposit not found or status is not valid.',
            ], 404);
        }
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

    public function updateDepositRequestRandomKey(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'depsoitId'  => 'required',
            'randomString'  => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        //dd($request->all());
        $id           = $request->depsoitId;
        $randomString = $request->randomString;
        $checkpost = Deposit::where('id', $id)->where('status', 0)->first();
        if ($checkpost) {
            $checkpost->random_key = $randomString;
            $checkpost->save();
            return response()->json([
                'message' => 'updated successfully.',
            ], 200);
        } else {
            return response()->json([
                'message' => 'Deposit not found or status is not valid.',
            ], 404);
        }
    }



    public function sendDepositRequestBank(Request $request)
    {
        //dd($request->all());
        //dd($request->all());
        $validator = Validator::make(
            $request->all(),
            [
                'inputAmount'     => 'required',
                'deposit_amount'  => 'required',
                'file'            => 'required',
            ],
            [
                'inputAmount.required'   => 'The amount field is required. Please enter a valid amount.',
                'file.required'          => 'Allowed only Images.',
            ]
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $setting = Setting::find(1);
        $checkSetting = $setting->minimum_deposit_amount;
        // if ($request->deposit_amount <= $checkSetting) {
        if ($request->inputAmount <= 0) {
            return response()->json(['errors' => ['deposit_amount' => ['Your deposit amount is low']]], 422);
        }

        $uniqueID = 'D.' . $this->generateUnique4DigitNumber();
        $data = array(
            'depositID'         => $uniqueID,
            'depscription'      => $uniqueID,
            'deposit_amount'    => $request->deposit_amount,
            'currencySymbol'    => $request->currencySymbol,
            'bank_name'         => $request->bank_name,
            'account_name'      => $request->account_name,
            'account_number'    => $request->account_number,
            'ific_code'         => $request->ific_code,
            'swift_code'        => $request->swift_code,
            'others_code'       => $request->others_code,
            'inputAmount'       => $request->inputAmount,
            'countryId'         => $request->countryId,
            'country_wise_bank_id' => $request->country_wise_bank_id,
            'payment_method'    => "BANK",
            'trxId'             => uniqid(),
            'status'         => 0,
            'user_id'        => $this->userid
        );

        if (!empty($request->file('file'))) {
            $files = $request->file('file');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/deposit_screenshort/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/deposit_screenshort/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['depsoit_images'] = $file_url;
        }
        //dd($data['depsoit_images']);
        $last_Id = Deposit::insertGetId($data);

        return response()->json("Last Deposit Id: $last_Id");
    }


    public function sendDepositRequestCrypto(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make(
            $request->all(),
            [
                'amount'     => 'required',
                'waAddress'  => 'required',
                'image'      => 'required',
            ],
            [
                'amount.required'        => 'The amount field is required. Please enter a valid amount.',
                'waAddress.required'     => 'Please provide valid address.',
                'image.required'         => 'Allowed only Images.',
            ]
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $setting = Setting::find(1);
        $checkSetting = $setting->minimum_deposit_amount;
        // if ($request->deposit_amount <= $checkSetting) {
        if ($request->amount <= 0) {
            return response()->json(['errors' => ['deposit_amount' => ['Your deposit amount is low']]], 422);
        }

        $uniqueID = 'D.' . $this->generateUnique4DigitNumber();
        $data = array(
            'depositID'         => $uniqueID,
            'depscription'      => $uniqueID,
            'deposit_amount'    => $request->amount,
            'gaming_pltform_id' => $request->gamingPltform,
            'cryptoType'        => $request->cryptoType,
            'payment_method'    => "CRYPTO",
            'trxId'             => uniqid(),
            'to_crypto_wallet_address'   => "",
            'frm_wallet_address'         => "",
            'status'         => 0,
            'user_id'        => $this->userid
        );

        if (!empty($request->file('image'))) {
            $files = $request->file('image');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/deposit_screenshort/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/deposit_screenshort/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['depsoit_images'] = $file_url;
        }
        //dd($data['depsoit_images']);
        $last_Id = Deposit::insertGetId($data);

        return response()->json("Last Deposit Id: $last_Id");
    }

    function generateUnique4DigitNumber($existingNumbers = [])
    {
        do {
            $uniqueNumber = str_pad(mt_rand(0, 9999), 4, '0', STR_PAD_LEFT);
        } while (in_array($uniqueNumber, $existingNumbers));

        return md5($uniqueNumber);
    }

    public function getWithMethodList()
    {
        $data     = WithdrawMethod::where('user_id', $this->userid)->get();
        foreach ($data as $v) {

            $tran[] = [
                'id'             => $v->id,
                'name'     => $v->name,
                'account_number' => $v->account_number,
            ];
        }

        return response()->json($tran, 200);
    }

    public function getWithdrawRequest()
    {

        $data     = Withdraw::where('user_id', $this->userid)->get();
        foreach ($data as $v) {

            if ($v->status == 0) {
                $wStatus = 'Review';
            } elseif ($v->status == 1) {
                $wStatus = 'Approved';
            } elseif ($v->status == 2) {
                $wStatus = 'Reject';
            }

            $tran[] = [
                'id'             => $v->id,
                'withdrawID'     => $v->withdrawID,
                'payment_method' => $v->payment_method,
                'account_number' => $v->account_number,
                'wStatus'        => $wStatus,
                'status'         => $v->status,
                'usd_amount'     => $v->usd_amount,
                'uic_amount'     => $v->uic_amount,
                'created_at'     => date("d-m-Y H:i:s", strtotime($v->created_at)),
            ];
        }

        return response()->json($tran, 200);
    }

    public function getwithdrawalList(Request $request)
    {
        // dd($request->all());
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        $searchEmail    = $request->searchEmail;
        $filterFrmDate  = $request->filterFrmDate;
        $filterToDate   = $request->filterToDate;
        $searchOrderId  = $request->searchOrderId;

        $query = Withdraw::orderBy('withdraw.id', 'desc')
            ->select('withdraw.*', 'users.name', 'users.email', 'users.phone_number')
            ->join('users', 'withdraw.user_id', '=', 'users.id') // Join condition
            ->orderBy('withdraw.id', 'desc'); // Sorting by 'id' in descending order

        if (!empty($searchOrderId)) {
            $query->where('withdraw.withdrawID', $searchOrderId);
        }

        // Check if filter dates are provided
        if (!empty($filterFrmDate) && !empty($filterToDate)) {
            // Filter by range (inclusive)
            $query->whereBetween(DB::raw('DATE(withdraw.created_at)'), [$filterFrmDate, $filterToDate]);
        } elseif (!empty($filterFrmDate)) {
            // If only from date is provided, filter by that specific date
            $query->where(DB::raw('DATE(withdraw.created_at)'), $filterFrmDate);
        } elseif (!empty($filterToDate)) {
            // If only to date is provided, filter by that specific date
            $query->where(DB::raw('DATE(withdraw.created_at)'), $filterToDate);
        }

        if (!empty($searchEmail)) {
            $query->where('users.email', $searchEmail);
        }

        $cleanedSelectedFilter = isset($selectedFilter) ? (int) trim($selectedFilter) : null;

        if ($cleanedSelectedFilter == 5) {
            $query->whereIn('withdraw.status', [0, 1, 2]);
        } else {
            $query->where('withdraw.status', $cleanedSelectedFilter);
        }

        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $status = "";
            if ($item->status == 0) {
                $status = "Review";
            } else if ($item->status == 1) {
                $status = "Approved";
            } else if ($item->status == 2) {
                $status = "Rejected";
            }
            $userrow = User::find($item->user_id);
            return [
                'id'                => $item->id,
                'withdrawID'        => $item->withdrawID,
                'user_info_name'    => !empty($userrow->name) ?  $userrow->name : "N/A",
                'user_info_email'   => !empty($userrow->email) ?  $userrow->email : "N/A",
                'user_info_phone'   => !empty($userrow->phone_number) ?  $userrow->phone_number : "N/A",
                'created_at'        => date("Y-m-d H:i:s", strtotime($item->created_at)),
                'usd_amount'        => $item->usd_amount,
                'uic_amount'        => $item->uic_amount,
                'payable_amount'    => $item->payable_amount,
                'transection_fee'   => $item->transection_fee,
                'withdrawal_method_id' => $item->withdrawal_method_id,
                'status'            => $status,
                'sts'               => $item->status,
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

    public function getWithdrwalfetchdata(Request $request)
    {

        $userId           = $this->userid;
        $frmDate          = $request->frmDate;
        $toDate           = $request->toDate;
        $withdrawal_Id    = $request->withdrawal_Id;

        $query = Withdraw::where('user_id', $userId)->select('id', 'withdrawID', 'created_at', 'withdrawal_amount', 'remarks', 'status');

        if ($withdrawal_Id) {
            $query->where('withdrawID', 'like', '%' . $withdrawal_Id . '%');
        }
        if ($frmDate && $toDate) {
            $query->whereBetween('created_at', [$frmDate, $toDate]);
        } elseif ($frmDate) {
            $query->where('created_at', '>=', $frmDate);
        } elseif ($toDate) {
            $query->where('created_at', '<=', $toDate);
        }

        $data = $query->get();

        return response()->json([
            'withdrwalData'        => $data,
        ]);
    }

    public function getDepositfetchdata(Request $request)
    {

        $userId           = $this->userid;
        $frmDate          = $request->frmDate;
        $toDate           = $request->toDate;
        $trxId            = $request->trxId;

        $query = Deposit::where('user_id', $userId)->select('id', 'trxId', 'created_at', 'deposit_amount', 'status');

        if ($trxId) {
            $query->where('trxId', 'like', '%' . $trxId . '%');
            // $query->where('trxId', $trxId);
        }
        if ($frmDate && $toDate) {
            $query->whereBetween('created_at', [$frmDate, $toDate]);
        } elseif ($frmDate) {
            $query->where('created_at', '>=', $frmDate);
        } elseif ($toDate) {
            $query->where('created_at', '<=', $toDate);
        }

        $data = $query->get();

        $response      = app('App\Http\Controllers\Balance\BalanceController')->getBalance();
        $depositAmount = $response instanceof JsonResponse ? $response->getData(true)['usdt_amount'] : 0;
        $maxWithdraw   = Setting::find(1);
        $walletAddress = UserPaymentAddress::where('user_id', $userId)->first();

        $wdata['minimum_withdrawal'] = $maxWithdraw->minimum_withdrawal;
        $wdata['maximum_withdrawal'] = $maxWithdraw->maximum_withdrawal;

        return response()->json([
            'depositData'        => $data,
            'depositAmount'      => $depositAmount,
            'withdrawData'       => $wdata,
            'walletAddress'      => $walletAddress,
        ]);
    }

    public function getDepositList(Request $request)
    {

        $page           = $request->input('page', 1);
        $pageSize       = $request->input('pageSize', 10);
        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        $searchEmail    = $request->searchEmail;
        $filterFrmDate  = $request->filterFrmDate;
        $filterToDate   = $request->filterToDate;
        $searchOrderId  = $request->searchOrderId;

        // dd($selectedFilter);
        $query = Deposit::orderBy('deposit.id', 'desc')
            ->join('users', 'deposit.user_id', '=', 'users.id') // Join condition
            ->select('deposit.*', 'users.email', 'users.name', 'users.phone_number')
            ->orderBy('deposit.id', 'desc'); // Sorting by 'id' in descending order

        // Check if filter dates are provided
        if (!empty($filterFrmDate) && !empty($filterToDate)) {
            // Filter by range (inclusive)
            $query->whereBetween(DB::raw('DATE(deposit.created_at)'), [$filterFrmDate, $filterToDate]);
        } elseif (!empty($filterFrmDate)) {
            // If only from date is provided, filter by that specific date
            $query->where(DB::raw('DATE(deposit.created_at)'), $filterFrmDate);
        } elseif (!empty($filterToDate)) {
            // If only to date is provided, filter by that specific date
            $query->where(DB::raw('DATE(deposit.created_at)'), $filterToDate);
        }

        if (!empty($searchEmail)) {
            $query->where('users.email', $searchEmail);
        }

        if (!empty($searchOrderId)) {
            // $query->where('depositID', 'like', '%' . $searchQuery . '%');
            $query->where('deposit.depositID', $searchOrderId);
        }

        // $cleanedSelectedFilter = isset($selectedFilter) ? (int) trim($selectedFilter) : null;

        if ($selectedFilter == 5) {
            $query->whereIn('deposit.status', [0, 1, 2]);
        } else {
            $query->where('deposit.status', $selectedFilter);
        }

        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $status = "";
            if ($item->status == 0) {
                $status = "Review";
            } else if ($item->status == 1) {
                $status = "Approved";
            } else if ($item->status == 2) {
                $status = "Rejected";
            }
            //Payment not received
            $userrow = User::find($item->user_id);
            return [
                'id'                => $item->id,
                'depositID'         => $item->depositID,
                'user_info_name'    => !empty($userrow->name) ?  $userrow->name : "N/A",
                'user_info_email'   => !empty($userrow->email) ?  $userrow->email : "N/A",
                'user_info_phone'   => !empty($userrow->phone_number) ?  $userrow->phone_number : "N/A",
                'deposit_amount'    => $item->deposit_amount,
                'receivable_amount' => !empty($item->receivable_amount) ? $item->receivable_amount : "Payment not received",
                'payment_method'    => $item->payment_method,
                'created_at'        =>  date("Y-m-d H:i:s", strtotime($item->created_at)),
                'status'            => $status,
                'sts'               => $item->status,
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

    public function withdrawrow($id)
    {

        try {

            $user = Withdraw::where('withdraw.id', $id)
                ->select('users.name', 'withdraw.*')
                ->join('users', 'withdraw.user_id', '=', 'users.id')
                ->first();

            $wallet_address         = !empty($user->wallet_address) ? $user->wallet_address : "";
            $data['datarow']        = $user;
            $data['created_at']     = !empty($user->created_at) ? date("d-m-Y H:i:s", strtotime($user->created_at)) : "";
            $data['remarks']        = !empty($user->remarks) ? $user->remarks : "";
            $data['wallet_address'] = $wallet_address;
            return response()->json($data);
        } catch (\Exception $e) {
            echo "Error: " . $e->getMessage();
            $error = $e->getMessage();
            return response()->json($error);
        }
    }

    public function getWithMethodRow(Request $request)
    {
        $data = WithdrawMethod::where('id', $request->id)->first();
        return response()->json($data);
    }

    public function depositCancel($id)
    {
        $deposit = Deposit::find($id);
        $deposit->status = 2;
        $deposit->save();
        return response()->json([
            'success' => true,
            'message' => 'Deposit has been successfully cancelled.',
            'data'    => $deposit
        ]);
    }



    public function checkDepositrow(Request $request)
    {

        $id = $request->depositId ?? "";
        try {
            $user = Deposit::where('deposit.id', $id)
                ->select('users.name', 'deposit.*')
                ->leftJoin('users', 'deposit.user_id', '=', 'users.id')
                ->first();

            $user['depsoit_images']  = !empty($user->depsoit_images) ? url($user->depsoit_images) : "";

            return response()->json($user);
        } catch (\Exception $e) {
            echo "Error: " . $e->getMessage();
            $error = $e->getMessage();
            return response()->json($error);
        }
    }

    public function depositrow($id)
    {
        try {
            $user = Deposit::where('deposit.id', $id)
                ->select('users.name', 'deposit.*')
                ->leftJoin('users', 'deposit.user_id', '=', 'users.id')
                ->first();

            $depsoitamount = !empty($user->deposit_amount) ? number_format($user->deposit_amount, 2) : 0;
            $user['depositimage']  = !empty($user->depsoit_images) ? url($user->depsoit_images) : "";
            $user['deposit_amount'] = $depsoitamount;

            return response()->json($user);
        } catch (\Exception $e) {
            echo "Error: " . $e->getMessage();
            $error = $e->getMessage();
            return response()->json($error);
        }
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


    public function userDepositHistory(Request $request)
    {
        $sDate              = $request->filterFrmDate;
        $eDate              = $request->filterToDate;
        $searchTranId       = $request->searchtxt;
        $selectedStatus     = $request->selectedFilter;
        $startDate          = Carbon::parse($sDate)->startOfDay();
        $endDate            = Carbon::parse($eDate)->endOfDay();

        // dd($selectedFilter);
        $query = Deposit::orderBy('deposit.id', 'desc')
            ->join('users', 'deposit.user_id', '=', 'users.id')
            ->select(
                'deposit.*',
                'users.name',
                'users.username',
                'users.telegram',
                'users.phone_number',
                'users.whtsapp',
                'users.email'
            );
        if ($searchTranId !== null) {
            $query->where('deposit.depositID', 'like', '%' . $searchTranId . '%');
            //$query->where('users.email', $searchOrderId);
        }
        if ($selectedStatus !== null) {
            if ($selectedStatus == 5) {
                $query->whereIn('deposit.status', [0, 1, 2]);
            } else {
                $query->where('deposit.status', $selectedStatus);
            }
        }
        // Apply date range filtering if start and end dates are provided
        if ($startDate !== null && $endDate !== null) {
            $query->whereBetween('deposit.created_at', [$startDate, $endDate]);
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
                'depositID'             => $item->depositID,
                'deposit_date'          => date("Y-M-d", strtotime($item->created_at)),
                'deposit_amount'        => number_format($item->deposit_amount, 2),
                'wallet_address'        => $item->wallet_address,
                'receivable_amount'     => $item->receivable_amount,
                'status'                => $item->status,
                'username'              => $item->username,
                'payment_method'        => $item->payment_method,
                'email'                 => $item->email,
                'statusName'            => $statusLabels[$item->status] ?? 'Unknown'
            ];
        });

        // Return the modified collection along with pagination metadata
        return response()->json([
            'data' => $modifiedCollection,
        ], 200);
    }
}
