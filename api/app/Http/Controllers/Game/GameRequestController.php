<?php

namespace App\Http\Controllers\Game;

use App\Http\Controllers\Controller;
use App\Models\ApiConfig;
use App\Models\Currency;
use App\Models\Game;
use App\Models\GameCategory;
use App\Models\GameList;
use App\Models\GamePlatform;
use App\Models\GamePlatforms;
use App\Models\GamesAll;
use App\Models\GamesListTranslate;
use App\Models\GameType;
use App\Models\GameTypeModel;
use App\Models\playerList;
use App\Models\User;
use App\Rules\MatchOldPassword;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Auth;
use DB;
use Helper;
use PhpOffice\PhpSpreadsheet\Calculation\DateTimeExcel\Current;
use Session;
use Validator;

class GameRequestController extends Controller
{
    protected $userid;
    protected $sn;
    protected $secretKey;
    protected $currency;
    protected $len;
    protected $ingress;

    public function __construct()
    {
        $this->middleware('auth:api');
        $id = auth('api')->user();
        if (!empty($id)) {
            $user = User::find($id->id);
            $this->userid = $user->id;
            $this->sn = 'guw';  // Replace with your SN
            $this->secretKey = '2SW80tB9C22800TrO64f9HcA761JR299';  // Replace with your secret key
            $this->currency = 'USD';  // CNY
            $this->len = 'en-us';
            $this->ingress = 'device1';
        }
    }

    public function platformTypeGames(Request $request)
    {
        // dd($request->all());
        $uCheckPoint = User::where('id', $this->userid)->first();
        $username = $uCheckPoint->username ?? '';
        $chkGameType = GameType::where('id', $request->gameType)->first();
        $gameTypeCode = (int) $chkGameType->gameTypecode ?? '';
        $pltName = $chkGameType->name ?? '';

        // Input Data
        $playerId = $username;  // "test001";
        $platType = $request->platType ?? '';  // "ag";
        $currency = $this->currency;  // "CNY";
        $gameType = $gameTypeCode;  // 2; // Adding gameType parameter
        //$return = $this->createPlayer($playerId, $platType, $currency, $gameType);

        $platformPlayGames = $this->platformPlayGames($playerId, $platType, $currency, $gameType, $gameTypeCode);
        //  dd($platformPlayGames);
        // Decode the response
        $responseData = json_decode(json_encode($platformPlayGames), true);
        // dd($responseData);

        // Extract code and msg from response_url
        $responseCode = $responseData['response_url']['code'] ?? null;

        $responseMessage = $responseData['response_url']['msg'] ?? null;
        $dataUrl = $responseData['response_url']['data']['url'] ?? null;

        // Debug extracted variables
        // Conditions based on responseCode
        if ($responseCode == 10000) {
            // Success: Return JSON URL
            return response()->json([
                'success' => true,
                'status' => 200,
                'pltName' => $pltName,
                'url' => $dataUrl,
            ]);
        } else {
            // Map error codes to messages
            $errorMessages = [
                10001 => 'Fail',
                10002 => 'Account already exists',
                10003 => 'Account does not exist',
                10004 => 'Account format error',
                10005 => 'Credit conversion failed',
                10006 => 'Wrong amount converted',
                10007 => 'Wrong time format',
                10008 => 'Link format error',
                10009 => 'Frequent interface requests',
                10010 => 'This game does not support trial play',
                10011 => 'The order number does not meet the requirements',
                10012 => 'Duplicate order number',
                10013 => 'The order number does not exist',
                10014 => 'Insufficient credit',
                10403 => 'IP restricted access',
                10404 => 'Signature verification failed',
                10405 => 'Missing parameters',
                10407 => 'Game platform error',
                10408 => 'Wrong game type',
                10409 => 'Conversion type error',
            ];

            $errorMessage = $errorMessages[$responseCode] ?? 'Unknown error';

            return response()->json([
                'success' => false,
                'code' => $responseCode,
                'status' => 422,
                'pltName' => $pltName,
                'message' => $errorMessage,
            ]);
        }
    }

    public function platformPlayGames($playerId, $platType, $currency, $gameType, $gameTypeCode)
    {
        $uCheckPoint = User::where('id', $this->userid)->first();
        $username = $uCheckPoint->username ?? '';
        // Configuration
        $apiUrl = 'https://ap.api-bet.net/api/server/gameUrl';
        $sn = $this->sn;
        $secretKey = $this->secretKey;  // Replace with your secret key

        // Input Data
        $playerId = $username;  // "test001";
        $platType = $platType ?? '';  // "ag";
        $currency = $this->currency;  // "CNY";
        $gameType = $gameTypeCode;  // 2; // Adding gameType parameter
        // $this->createPlayer($playerId, $platType, $currency, $gameType);
        // exit;
        // Generate headers
        $random = $this->generateRandomString();
        $signature = $this->generateSignature($random, $sn, $secretKey);

        // Prepare the request payload
        $data = [
            'playerId' => $playerId,
            'platType' => $platType,
            'currency' => $currency,
            'gameType' => $gameType,
            'lang' => 'en-us',  // $this->len, //'en',
            'ingress' => $this->ingress,  // 'device1',
        ];

        $headers = ['Content-Type: application/json', "random: $random", "sign: $signature", "sn: $sn"];
        // Initialize cURL
        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_URL => $apiUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => $headers,
        ]);

        $response = curl_exec($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $err = curl_error($curl);
        $jsonData = json_encode($data, JSON_PRETTY_PRINT);
        curl_close($curl);

        $decodedResponse = json_decode($response, true);  // Decode the JSON response

        if ($err) {
            return [
                'error' => true,
                'message' => $err,
            ];
        }

        return [
            'httpCode' => $httpCode,
            'response_url' => json_decode($response, true),
            'requestPayload' => $data,
        ];
    }


    public function requesttoGame(Request $request)
    {

        $chckCurrency = Currency::where('status',1)->first();
        $curr         = !empty($chckCurrency) ? $chckCurrency->name : "INR";
        $id = $request->slug;
        $gameRow = GameList::where('id', $id)->first();
        // dd($gameRow);
        $userId = $this->userid;
        $user = User::find($userId);
        $username = !empty($user->username) ? $user->username : '';
        $gameName = $gameRow->gameName_en ?? '';

        // Configuration
        $apiUrl = 'https://ap.api-bet.net/api/server/gameUrl';
        $sn = $this->sn;
        $secretKey = $this->secretKey;  // Replace with your secret key

        // Input Data
        $playerId = $username;
        $platType = $gameRow->platType ?? '';  // "bbin";
        $currency = $curr;//$this->currency;  // "CNY";
        $gameType = $gameRow->gameType ?? '';  // 2; // Adding gameType parameter
        //$gameCode = $gameRow->gameCode ?? '';  // 5185;
        $this->createPlayer($username, $platType, $currency, $gameType);
      
        $random = $this->generateRandomString();
        $signature = $this->generateSignature($random, $sn, $secretKey);

        // Prepare the request payload
        $data = [
            'playerId' => $playerId,
            'platType' => $platType,
            'currency' => $currency,
            'gameType' => $gameType,
            'lang' => 'en-us',  // $this->len,
          //  'gameCode' => $gameCode,
            'ingress' => 'device1',
        ];
        // dd($data);

        $headers = ['Content-Type: application/json', "random: $random", "sign: $signature", "sn: $sn"];
        // Initialize cURL
        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_URL => $apiUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => $headers,
        ]);

        $response = curl_exec($curl);
        // dd($response);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $err = curl_error($curl);
        $jsonData = json_encode($data, JSON_PRETTY_PRINT);
        curl_close($curl);

        $decodedResponse = json_decode($response, true);  // Decode the JSON response
        //   dd($decodedResponse);
        if ($err) {
            return [
                'error' => true,
                'message' => $err,
            ];
        }

        $errorMessages = [
            10001 => 'Fail',
            10002 => 'Account already exists',
            10003 => 'Account does not exist',
            10004 => 'Account format error',
            10005 => 'Credit conversion failed',
            10006 => 'Wrong amount converted',
            10007 => 'Wrong time format',
            10008 => 'Link format error',
            10009 => 'Frequent interface requests',
            10010 => 'This game does not support trial play',
            10011 => 'The order number does not meet the requirements',
            10012 => 'Duplicate order number',
            10013 => 'The order number does not exist',
            10014 => 'Insufficient credit',
            10403 => 'IP restricted access',
            10404 => 'Signature verification failed',
            10405 => 'Missing parameters',
            10407 => 'Game platform error',
            10408 => 'Wrong game type',
            10409 => 'Conversion type error',
        ];

        $responseCode = $decodedResponse['code'] ?? null;  // Get the response code
        $httpCode = $decodedResponse['httpCode'] ?? null;  // Get the HTTP status code if available

        if ($responseCode == 10000) {
            return [
                'httpCode' => $httpCode,
                'code' => $responseCode,
                'resStatus' => 200,
                'response_url' => json_decode($response, true),
                'requestPayload' => $data,
            ];
        } else {
            $errorMessage = $errorMessages[$responseCode] ?? 'Unknown error';
            return [
                'httpCode' => $httpCode,
                'code' => $responseCode,
                'error' => true,
                'resStatus' => 422,
                'message' => "$errorMessage",
                'responseCode' => $responseCode,
                'response' => $decodedResponse,
            ];
        }
    }

    public function checkGameBalance(Request $request)
    {

        //Player checking
        $gameId     = $request->gameId ?? '';
        $userId     = $this->userid;
        $user       = User::find($userId);
        $username   = !empty($user->username) ? $user->username : '';
        $gameRow    = GameList::where('id', $gameId)->first();

        // Input Data
        $playerId = $username;
        $platType = $gameRow->platType ?? '';  // "bbin,AG,JDB ETC.";

        $apiBalanceController = app('App\Http\Controllers\Balance\BalanceController')->getCurrentBalance();
        $responseArray        = $apiBalanceController->getData(true);
        // Check if balance exists in the response
        if (isset($responseArray['data']['balance'])) {
            $balance   = $responseArray['data']['balance'];
            $currency  = $responseArray['currency'];
        } else {
            $balance   = null; // Handle cases where balance isn't returned
            $currency  = null;
        }


        $data['balance'] = "Your available balance is: {$currency} {$balance}";

        return response()->json($data, 200);
    }

    function generateRandomString($length = 16)
    {
        return substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyz', $length)), 0, $length);
    }

    function generateSignature($random, $sn, $secretKey)
    {
        return md5($random . $sn . $secretKey);
    }


    public function createPlayer($username, $platType, $currency, $gameType)
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
        $gameType  = $gameType; // Adding gameType parameter
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
        $this->logResponse($apiUrl, $headers, $data, $httpCode, $response, $err);
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


    // this method backup
    /*
    public function checkGameBalance(Request $request)
    {
        $gameId = $request->gameId ?? '';
        $userId = $this->userid;
        $user = User::find($userId);
        $username = !empty($user->username) ? $user->username : '';

        $gameRow = GameList::where('id', $gameId)->first();

        // Configuration
        $apiUrl = 'https://ap.api-bet.net/api/server/balance';
        $sn = $this->sn;
        $secretKey = $this->secretKey;  // Replace with your secret key
        // Input Data
        $playerId = $username;
        $platType = $gameRow->platType ?? '';  // "bbin";
        $currency = $this->currency;  // "CNY";
        // Generate headers
        $random = $this->generateRandomString();
        $signature = $this->generateSignature($random, $sn, $secretKey);

        // Prepare the request payload
        $data = [
            'playerId' => $playerId,
            'platType' => $platType,
            'currency' => $currency,
        ];
        // dd($data);

        $headers = ['Content-Type: application/json', "random: $random", "sign: $signature", "sn: $sn"];
        // Initialize cURL
        $curl = curl_init();

        curl_setopt_array($curl, [
            CURLOPT_URL => $apiUrl,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_HTTPHEADER => $headers,
        ]);

        $response = curl_exec($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $err = curl_error($curl);
        $jsonData = json_encode($data, JSON_PRETTY_PRINT);
        curl_close($curl);

        $decodedResponse = json_decode($response, true);  // Decode the JSON response
        if ($err) {
            return [
                'error' => true,
                'message' => $err,
            ];
        }

        //  dd($decodedResponse);

        $responseCode = $decodedResponse['code'] ?? null;  // Get the response code
        $responseMSg = $decodedResponse['msg'] ?? null;  // Get the response code
        $balance = $decodedResponse['data']['balance'] ?? null;

        if ($responseCode == 10000) {
            return [
                'code' => $responseCode,
                'resStatus' => 200,
                'responseMSg' => $responseMSg,
                'balance' => $balance,
                'currency' => $this->currency,
            ];
        } else {
            $errorMessage = $errorMessages[$responseCode] ?? 'Unknown error';
            return [
                'code' => $responseCode,
                'resStatus' => 422,
                'responseMSg' => $errorMessage,
                'balance' => '',
            ];
        }
    }
    */
}
