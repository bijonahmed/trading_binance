<?php

namespace App\Http\Controllers\User;

use DB;
use Auth;
use File;
use Helper;
use Validator;
use App\Models\User;
use App\Models\Order;
use App\Models\Videos;
use App\Models\Deposit;
use App\Models\Gallery;
use App\Models\Profile;
use App\Models\Countrys;
use App\Models\Community;
use App\Models\RuleModel;
use Illuminate\Support\Str;
use function Ramsey\Uuid\v1;
use Illuminate\Http\Request;
use App\Models\ExpenseHistory;
use App\Models\MystoreHistory;
use App\Models\VideosThunmnail;
use App\Rules\MatchOldPassword;
use App\Models\ManualAdjustment;
use Illuminate\Http\JsonResponse;
use PhpParser\Node\Stmt\TryCatch;
use App\Http\Controllers\Controller;
use App\Models\Kyc;
use Illuminate\Support\Facades\Hash;
use App\Models\ManualAdjustmentDelete;
use App\Models\MiningServicesBuyHistory;

class UserController extends Controller
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


    public function kycVerification()
    {
        $checkPoint = Kyc::where('user_id', $this->userid)->first();
        if ($checkPoint && $checkPoint->status == 1) { // Proper null check
            $data['verfication_status'] = 1;
        } else {
            $data['verfication_status'] = 0;
        }

        return response()->json($data, 200);
    }




    public function checkPassport()
    {
        $checckPassport = Kyc::where('user_id', $this->userid)
            ->whereNotNull('passport') // Ensure passport is not null
            ->first();
        if (!empty($checckPassport)) {
            $data['passport_status'] = 1;
            $data['passport_img']    = !empty($checckPassport->passport) ? url($checckPassport->passport) : "";
        } else {
            $data['passport_status'] = 0;
            $data['passport_img']    = "";
        }
        return response()->json($data, 200);
    }


    public function checkDriveLince()
    {
        $checkDrivLin = Kyc::where('user_id', $this->userid)
            ->whereNotNull('dl_front')
            ->whereNotNull('dl_back') // Ensure both dl_front and dl_back are not null
            ->first();

        if (!empty($checkDrivLin)) {
            $data['dl_status']       = 1;
            $data['dl_front_img']    = !empty($checkDrivLin->dl_front) ? url($checkDrivLin->dl_front) : "";
            $data['dl_back_img']     = !empty($checkDrivLin->dl_back) ? url($checkDrivLin->dl_back) : "";
        } else {
            $data['dl_status']       = 0;
            $data['dl_front_img']    =  "";
            $data['dl_back_img']     = "";
        }
        return response()->json($data, 200);
    }



    public function checkNationalCard()
    {
        $checkDrivLin = Kyc::where('user_id', $this->userid)
            ->whereNotNull('frontFile_nid')
            ->whereNotNull('backFile_nid') // Ensure both dl_front and dl_back are not null
            ->first();

        if (!empty($checkDrivLin)) {
            $data['idCard_status']      = 1;
            $data['idCardfront_img']    = !empty($checkDrivLin->frontFile_nid) ? url($checkDrivLin->frontFile_nid) : "";
            $data['idCardback_img']     = !empty($checkDrivLin->backFile_nid) ? url($checkDrivLin->backFile_nid) : "";
        } else {
            $data['idCard_status']      = 0;
            $data['idCardfront_img']    = "";
            $data['idCardback_img']     = "";
        }
        return response()->json($data, 200);
    }




    public function checkuser()
    {
        try {
            $user = User::where('id', $this->userid)->first();
            $users = [
                'id'            => $user->id,
                'name'          => $user->name,
                'email'         => $user->email,
                'username'      => $user->username,
                'register_ip'   => $user->register_ip,
                'inviteCode'    => $user->inviteCode,
                'phone_number'  => $user->phone_number,
                'createDate'    => date("Y-m-d", strtotime($user->created_at)),
                // Add other fields if necessary
            ];

            return response()->json($users, 200);
        } catch (\Exception $e) {
            \Log::error('Error retrieving user: ' . $e->getMessage());
            return response()->json(['message' => 'An error occurred while retrieving the user'], 500);
        }
    }


    public function checkUserRow()
    {
        try {
            $user              = User::where('id', $this->userid)->first();
            return response()->json($user, 200);
        } catch (\Exception $e) {
            \Log::error('Error retrieving user: ' . $e->getMessage());
            return response()->json(['message' => 'An error occurred while retrieving the user'], 500);
        }
    }



    public function checkCurrentUser()
    {
        try {
            $user              = User::where('id', $this->userid)->first();
            $data['user']      = $user;
            $data['image']     = !empty($user->image) ? url($user->image) : "";
            $data['country']   = Countrys::where('status', 1)->get();
            return response()->json($data, 200);
        } catch (\Exception $e) {
            \Log::error('Error retrieving user: ' . $e->getMessage());
            return response()->json(['message' => 'An error occurred while retrieving the user'], 500);
        }
    }

    public function me()
    {
        $me = auth('api')->user();
        return response()->json($me);
    }

    public function saveRole(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'status' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = User::addEditRole($request->all());
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function getUsersList(Request $request)
    {
        $data = User::getUsersList($request->all());
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }

    public function getDepartmentList(Request $request)
    {
        try {
            $rows = User::allDepartment($request->all());
            $response = [
                'data' => $rows,
                'message' => 'success'
            ];
        } catch (\Throwable $th) {
            $response = [
                'data' => [],
                'message' => 'failed'
            ];
        }
        return response()->json($response, 200);
    }
    public function typeofdoucments(Request $request)
    {
        try {
            $rows = User::alltypedocutms($request->all());
            $response = [
                'data' => $rows,
                'message' => 'success'
            ];
        } catch (\Throwable $th) {
            $response = [
                'data' => [],
                'message' => 'failed'
            ];
        }
        return response()->json($response, 200);
    }
    public function getDesignationList(Request $request)
    {
        try {
            $rows = User::allDesignation($request->all());
            $response = [
                'data' => $rows,
                'message' => 'success'
            ];
        } catch (\Throwable $th) {
            $response = [
                'data' => [],
                'message' => 'failed'
            ];
        }
        return response()->json($response, 200);
    }
    public function getEmployeeList(Request $request)
    {
        try {
            $rows = User::allEmployee($request->all());
            $response = [
                'data' => $rows,
                'message' => 'success'
            ];
        } catch (\Throwable $th) {
            $response = [
                'data' => [],
                'message' => 'failed'
            ];
        }
        return response()->json($response, 200);
    }

    public function allrolelist()
    {
        $activeRule = RuleModel::where('status', 1)->whereNot('id', 3)->get();
        return response()->json($activeRule);
    }
    public function allrolelistsInfo()
    {
        $activeRule = RuleModel::where('status', 1)->get();
        return response()->json($activeRule);
    }

    public function getRoleList(Request $request)
    {
        //RuleModel::all();

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = RuleModel::orderBy('rule.id', 'desc');
        if ($searchQuery !== null) {
            $query->where('rule.name', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {

            $query->where('rule.status', $selectedFilter);
        }
        // $query->whereNotIn('users.role_id', [2]);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {
            return [
                'id'            => $item->id,
                'name'          => $item->name,
                'created_at'    => date("Y-M-d H:i:s", strtotime($item->created_at)),
                'updated_at'    => date("Y-M-d H:i:s", strtotime($item->updated_at)),
                'status'        => $item->status == 1 ? 'Active' : 'Inactive',
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

    public function getUserWiseCurrentBalance(Request $request)
    {
        $userid = $request->userid;
        $response       = app('App\Http\Controllers\Dropshipping\DropUserController')->getCurrentBalanceCheckAdminIndivUser($userid);
        $currentBalance = $response instanceof JsonResponse ? $response->getData(true)['current_balance'] : 0;
        return response()->json($currentBalance);
    }

    public function allAgent(Request $request)
    {
        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = User::orderBy('users.id', 'desc')
            ->join('rule', 'users.role_id', '=', 'rule.id')
            ->select('users.created_at', 'users.updated_at', 'lastlogin_country', 'register_ip', 'lastlogin_ip', 'users.ref_id', 'users.telegram', 'users.whtsapp', 'users.role_id', 'users.id', 'users.name', 'users.email', 'users.phone_number', 'users.show_password', 'users.status', 'rule.name as rulename');
        if ($searchQuery !== null) {
            $query->where('users.name', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {
            $query->where('users.status', $selectedFilter);
        }
        $query->where('users.role_id', 4);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $status         = $item->status == 1  ? 'Active' : "None";
            $ref_id         = !empty($item->ref_id) ? $item->ref_id : ""; //$item->ref_id == 1  ? 'Active' : "None";
            $chkInviteUser  = User::where('id', $ref_id)->select('name', 'phone_number', 'email')->first();
            $registerIP     = $item->register_ip;
            $ipdat = @json_decode(file_get_contents(
                "http://www.geoplugin.net/json.gp?ip=" . $registerIP
            ));

            return [
                'id'            => $item->id,
                'name'          => substr($item->name, 0, 250),
                'rulename'      => substr($item->rulename, 0, 250),
                'email'         => $item->email,
                'phone_number'  => $item->phone_number,
                'show_password' => $item->show_password,
                'status'        => $status,
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

    public function allAdmin(Request $request)
    {

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = User::orderBy('users.id', 'desc')
            ->join('rule', 'users.role_id', '=', 'rule.id')
            ->select('users.created_at', 'users.updated_at', 'lastlogin_country', 'register_ip', 'lastlogin_ip', 'users.ref_id', 'users.telegram', 'users.whtsapp', 'users.role_id', 'users.id', 'users.name', 'users.email', 'users.phone_number', 'users.show_password', 'users.status', 'rule.name as rulename');
        if ($searchQuery !== null) {
            $query->where('users.name', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {
            $query->where('users.status', $selectedFilter);
        }
        $query->where('users.role_id', 3);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $status         = $item->status == 1  ? 'Active' : "None";
            $ref_id         = !empty($item->ref_id) ? $item->ref_id : ""; //$item->ref_id == 1  ? 'Active' : "None";
            $chkInviteUser  = User::where('id', $ref_id)->select('name', 'phone_number', 'email')->first();
            $registerIP     = $item->register_ip;
            $ipdat = @json_decode(file_get_contents(
                "http://www.geoplugin.net/json.gp?ip=" . $registerIP
            ));

            return [
                'id'            => $item->id,
                'name'          => substr($item->name, 0, 250),
                'rulename'      => substr($item->rulename, 0, 250),
                'email'         => $item->email,
                'phone_number'  => $item->phone_number,
                'show_password' => $item->show_password,
                'status'        => $status,
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
    public function allSuperAdmin(Request $request)
    {

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = User::orderBy('users.id', 'desc')
            ->join('rule', 'users.role_id', '=', 'rule.id')
            ->select('users.created_at', 'users.updated_at', 'lastlogin_country', 'register_ip', 'lastlogin_ip', 'users.ref_id', 'users.telegram', 'users.whtsapp', 'users.role_id', 'users.id', 'users.name', 'users.email', 'users.phone_number', 'users.show_password', 'users.status', 'rule.name as rulename');
        if ($searchQuery !== null) {
            $query->where('users.name', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedFilter !== null) {
            $query->where('users.status', $selectedFilter);
        }
        $query->where('users.role_id', 1);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $status         = $item->status == 1  ? 'Active' : "None";
            $ref_id         = !empty($item->ref_id) ? $item->ref_id : ""; //$item->ref_id == 1  ? 'Active' : "None";
            $chkInviteUser  = User::where('id', $ref_id)->select('name', 'phone_number', 'email')->first();
            $registerIP     = $item->register_ip;
            $ipdat = @json_decode(file_get_contents(
                "http://www.geoplugin.net/json.gp?ip=" . $registerIP
            ));

            return [
                'id'            => $item->id,
                'name'          => substr($item->name, 0, 250),
                'rulename'      => substr($item->rulename, 0, 250),
                'email'         => $item->email,
                'phone_number'  => $item->phone_number,
                'show_password' => $item->show_password,
                'status'        => $status,
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

    public function kycList(Request $request)
    {

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 100000);

        $searchUsername    = $request->searchUsername;
        $selectedFilter    = $request->selectedFilter;


        // dd($selectedFilter);
        $query = Kyc::orderBy('kyc.id', 'desc')
            ->join('users', 'kyc.user_id', '=', 'users.id')
            ->select(
                'kyc.*',
                'users.name',
                'users.username',
                'users.email'
            );

        if ($searchUsername !== null) {
            $query->where('users.username', 'like', '%' . $searchUsername . '%');
            //$query->where('users.email', $searchUserEmail);
        }


        if ($selectedFilter == 5) {
            $query->whereIn('kyc.status', [0, 1, 2]);
        } else {
            $query->where('kyc.status', $selectedFilter);
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
                'status'                => $item->status,
                'user_id'               => $item->user_id,
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

    public function allModels(Request $request)
    {

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery      = $request->searchQuery;
        $selectedFilter   = (int)$request->selectedFilter;
        $selectedCategory = $request->selectedCategory;
        // dd($selectedFilter);
        $query = Videos::orderBy('videos.video_id', 'desc');
        // ->join('rule', 'users.role_id', '=', 'rule.id')
        //->select('users.created_at', 'users.updated_at', 'lastlogin_country', 'register_ip', 'lastlogin_ip', 'users.ref_id', 'users.telegram', 'users.whtsapp', 'users.role_id', 'users.id', 'users.name', 'users.email', 'users.phone_number', 'users.show_password', 'users.status', 'rule.name as rulename');
        if ($searchQuery !== null) {
            $query->where('videos.title', 'like', '%' . $searchQuery . '%');
        }

        if ($selectedCategory !== null) {
            $query->where('videos.category', 'like', '%' . $selectedCategory . '%');
        }

        if ($selectedFilter !== null) {
            $query->where('videos.status', $selectedFilter);
        }
        //$query->where('users.role_id', 1);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $status         = $item->status == 1  ? 'Active' : "None";

            return [
                'id'            => $item->video_id,
                'apiId'         => $item->api_id,
                'category'      => $item->category,
                'title'         => $item->title,
                'thumb_src'     => $item->thumb_src,
                'status'        => $status,
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

    public function findUserDetails(Request $request)
    {

        $video_id = $request->id;
        $history  = VideosThunmnail::where('video_id', $video_id)->get();
        return response()->json($history); // Return the result as JSON

    }

    public function autocompleteUser(Request $request)
    {
        $query = $request->query('query', ''); // Get the 'query' parameter from the request
        // Retrieve users whose names contain the search query, case-insensitive
        $users = User::where('email', 'LIKE', "%{$query}%")->get();
        return response()->json($users); // Return the result as JSON

    }

    public function inactiveUser(Request $request)
    {

        $userId = $request->user_id;
        $data['status'] = 0;
        User::where('id', $userId)->update($data);
        return response()->json("Update successfully");
    }

    public function AllUsersList(Request $request)
    {

        $page = $request->input('page', 1);
        $pageSize = $request->input('pageSize', 10);

        // Get search query from the request
        $searchQuery    = $request->searchQuery;
        $selectedFilter = (int)$request->selectedFilter;
        // dd($selectedFilter);
        $query = User::orderBy('users.id', 'desc')
            ->join('rule', 'users.role_id', '=', 'rule.id')
            ->select('users.username', 'users.created_at', 'users.updated_at', 'lastlogin_country', 'register_ip', 'lastlogin_ip', 'users.ref_id', 'users.telegram', 'users.whtsapp', 'users.role_id', 'users.id', 'users.name', 'users.email', 'users.phone_number', 'users.show_password', 'users.status', 'rule.name as rulename');

        if ($searchQuery !== null) {
            //$query->where('users.email', 'like', '%' . $searchQuery . '%');
            $query->where('users.username', $searchQuery);
        }

        if ($selectedFilter !== null) {

            $query->where('users.status', $selectedFilter);
        }
        $query->where('users.role_id', 2);
        $paginator = $query->paginate($pageSize, ['*'], 'page', $page);

        $modifiedCollection = $paginator->getCollection()->map(function ($item) {

            $telegram       = !empty($item->telegram) ? $item->telegram : "None";
            $phone          = !empty($item->phone_number) ? $item->phone_number : "";
            $username       = !empty($item->username) ? $item->username : "";
            $whtsapp        = !empty($item->whtsapp) ? $item->whtsapp : "None";
            $status         = $item->status == 1  ? 'Active' : "Inactive";
            $ref_id         = !empty($item->ref_id) ? $item->ref_id : ""; //$item->ref_id == 1  ? 'Active' : "None";
            $chkInviteUser  = User::where('id', $ref_id)->select('name', 'phone_number', 'email')->first();
            $registerIP     = $item->register_ip;
            $ipdat = @json_decode(file_get_contents(
                "http://www.geoplugin.net/json.gp?ip=" . $registerIP
            ));

            return [
                'id'            => $item->id,
                'name'          => substr($item->name, 0, 250),
                'rulename'      => substr($item->rulename, 0, 250),
                'userInfo_1'    => "Name:" . $item->name,
                'userInfo_2'    => "Username:" . $username,
                'userInfo_3'    => "Email:" . $item->email,
                'userInfo_4'    => "Telegram:" . $telegram,
                'userInfo_5'    => "WhatsApp:" . $whtsapp,
                'invite_user_1' => !empty($chkInviteUser->name) ? "Name : " . $chkInviteUser->name : "", //!empty("Name:" . $chkInviteUser->name) ? "Name:" . $chkInviteUser->name : "",
                //'invite_user_2' => !empty($chkInviteUser->phone_number) ? $chkInviteUser->phone_number : "", //!empty("Cell Phone:" . $chkInviteUser->phone_number) ? "Cell Phone:" . $chkInviteUser->phone_number : "",
                'invite_user_3' => !empty($chkInviteUser->email) ? "Email : " . $chkInviteUser->email : "", //!empty("Email:" . $chkInviteUser->email) ? "Email:" . $chkInviteUser->email : "",
                'email'         => $item->email,
                'register_ip'   => $item->register_ip,
                'lastlogin_ip'  => $item->lastlogin_ip,

                'register_country'   => !empty($ipdat->geoplugin_countryName) ? $ipdat->geoplugin_countryName : "",
                'lastlogin_country'  => !empty($item->lastlogin_country) ?: "",

                'created_at'  => date("Y-M-d H:i:s", strtotime($item->created_at)), //$item->created_at,
                'updated_at'  => date("Y-M-d H:i:s", strtotime($item->updated_at)), //$item->updated_at,

                'phone_number'  => $item->phone_number,
                'show_password' => $item->show_password,
                'status'        => $status,
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

    public function editUserId($id)
    {

        $data = User::where('id', $id)->first();

        $response = [
            'data' => $data,
            'dataImg'  => !empty($data->image) ? url($data->image) : "",
            'doc_file' => !empty($data->doc_file) ? url($data->doc_file) : "",
            'message'  => 'success'
        ];
        return response()->json($response, 200);
    }

    public function roleCheck($id)
    {
        $data = User::checkRoleRow($id);
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function departmentCheck($id)
    {
        $data = User::checkDepartmentRow($id);
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function designationCheck($id)
    {
        $data = User::checkDesignationRow($id);
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function checkUserDetails($id)
    {
        $data = User::checkRoleRow($id);
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function getCountry()
    {
        $data = User::countryList();
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function getTime()
    {
        $data = User::getTimes();
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function inactiveEmployee()
    {
        $data = User::inactiveEmployees();
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function saveDepartment(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'status' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = array(
            'name'     => !empty($request->name) ? $request->name : "",
            'entry_by' => $this->userid,
            'status'   => $request->status,
        );
        if (empty($request->id)) {
            $id = DB::table('department')->insertGetId($data);
        } else {
            $id = $request->id;
            DB::table('department')->where('id', $request->id)->update($data);
        }
        $response = [
            'message' => 'User register successfully insert UserID:' . $id
        ];
        return response()->json($response);
    }
    public function saveDesignation(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'status' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = array(
            'name' => !empty($request->name) ? $request->name : "",
            'entry_by' => $this->userid,
            'status' => $request->status,
        );
        if (empty($request->id)) {
            $id = DB::table('designation')->insertGetId($data);
        } else {
            $id = $request->id;
            DB::table('designation')->where('id', $request->id)->update($data);
        }
        $response = [
            'message' => 'Successfull:' . $id,
        ];
        return response()->json($response);
    }

    public function updateUserProfileImg(Request $request)
    {
        // dd($request->all());
        $validator = Validator::make($request->all(), [
            //'file'    => 'required',
            'file' => 'required|image|mimes:jpeg,png,jpg,gif', // Adjust max file size as needed
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        if (!empty($request->file('file'))) {
            $files = $request->file('file');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['image'] = $file_url;
            DB::table('users')->where('id', $this->userid)->update($data);
            $response = [
                'dataImg' => !empty($file_url) ? url($file_url) : "",
                'message' => 'success'
            ];
        } else {
            $response = [
                'dataImg' =>  "",
                'message' => 'failed'
            ];
        }
        return response()->json($response);
    }

    public function updateUserEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users,email', // Ensure email is required, valid, and unique
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Get authenticated user ID
        $userId = auth()->id();

        $user = User::find($userId);
        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $user->update(['email' => $request->email]);

        return response()->json(['message' => 'User successfully updated.']);
    }

    public function updateUserPhone(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'phoneNumber' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Get authenticated user ID
        $userId = auth()->id();

        $user = User::find($userId);
        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $user->update(['phone_number' => $request->phoneNumber]);

        return response()->json(['message' => 'User successfully updated.']);
    }


    public function updateUser(Request $request)
    {
        // dd($request->all());
        $validator = Validator::make($request->all(), [
            'name'    => 'required|max:255',
            'status'  => 'required',
            // 'email' => 'required|email|max:255|unique:users,email,' . $this->userid,
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        //   $user = User::find($request->id);

        $data['status'] = $request->status;
        $data['name']   = $request->name;
        $data['phone_number'] = $request->phone_number;

        // Handle file upload
        if (!empty($request->file('file'))) {
            $files = $request->file('file');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $files->move(public_path($uploadPath), $path);
            $data['image'] = $uploadPath . $path;
        }


        // dd($data);
        // Update user data
        User::where('id', $request->id)->update($data);

        return response()->json(['message' => 'User successfully updated.']);
    }

    public function saveUser(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make($request->all(), [
            'role_id'    => 'required',
            'name'       => 'required',
            'phone'      => 'required',
            'email'      => 'required|email',
            // 'email' => 'required|email|unique:users',
            'password' => 'min:2|required_with:password_confirmation|same:password_confirmation',
            'password_confirmation' => 'min:2'
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = array(
            'role_id'       => !empty($request->role_id) ? $request->role_id : "",
            'name'          => !empty($request->name) ? $request->name : "",
            'address'       => !empty($request->address) ? $request->address : "",
            'phone_number'  => !empty($request->phone) ? $request->phone : "",
            'email'         => !empty($request->email) ? $request->email : "",
            'password'      => !empty($request->password) ? Hash::make($request->password) : "",
            'show_password' => !empty($request->password) ? $request->password : "",
            'status'        => $request->status,
            'entry_by'      => $this->userid,
        );
        if (!empty($request->file('file'))) {
            $files = $request->file('file');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['image'] = $file_url;
        }

        if (empty($request->id)) {
            $userId = DB::table('users')->insertGetId($data);
        } else {
            $userId = $request->id;
            DB::table('users')->where('id', $request->id)->update($data);
        }
        $response = [
            'message' => 'User register successfully insert UserID:' . $userId
        ];
        return response()->json($response);
    }
    public function assignToUser(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'role_id'    => 'required',
            'employee_id' => 'required',
            'name'       => 'required',
            'phone'      => 'required',
            'email'      => 'required|email',
            // 'email' => 'required|email|unique:users',
            'password' => 'min:2|required_with:password_confirmation|same:password_confirmation',
            'password_confirmation' => 'min:2'
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = array(
            'role_id'       => !empty($request->role_id) ? $request->role_id : "",
            'employee_id'   => !empty($request->employee_id) ? $request->employee_id : "",
            'name'          => !empty($request->name) ? $request->name : "",
            'address'       => !empty($request->address) ? $request->address : "",
            'phone_number'  => !empty($request->phone) ? $request->phone : "",
            'email'         => !empty($request->email) ? $request->email : "",
            'password'      => !empty($request->password) ? Hash::make($request->password) : "",
            'show_password' => $request->password,
            'status'        => $request->status,
            'entry_by'      => $this->userid,
        );
        if (!empty($request->file('file'))) {
            $files = $request->file('file');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['image'] = $file_url;
        }

        $userId = DB::table('users')->insertGetId($data);

        $response = [
            'message' => 'Successfully Assign to User. UserID:' . $userId
        ];
        return response()->json($response);
    }

    public function changePasswordClient(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'password' => 'required|min:2|confirmed', // Use 'confirmed' rule for password confirmation
            'password_confirmation' => 'required|min:2',
            'old_password' => 'required|min:2', // Add validation for old password
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = User::find($request->id);

        // Validate old password before updating
        if (!Hash::check($request->old_password, $user->password)) {
            return response()->json(['errors' => ['old_password' => ['The old password does not match.']]], 422);
        }

        $user->password = Hash::make($request->password);
        $user->show_password = $request->password; // Consider removing this line for security reasons
        $user->save();

        $response = "Password successfully changed!";
        return response()->json($response);
    }

    public function changePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'password' => 'min:2|required_with:password_confirmation|same:password_confirmation',
            'password_confirmation' => 'min:2'
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $user = User::find($request->id);
        $user->password = Hash::make($request->password);
        $user->show_password = $request->password;
        $user->save();
        $response = "Password successfully changed!";
        return response()->json($response);
    }

    public function updateUserProPass(Request $request)
    {
        // dd($request->all());
        $validator = Validator::make($request->all(), [
            //'file'    => 'required',
            'doc_file' => 'required|image|mimes:jpeg,png,jpg,gif', // Adjust max file size as needed
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        if (!empty($request->file('doc_file'))) {
            $files = $request->file('doc_file');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['doc_file'] = $file_url;
            DB::table('users')->where('id', $this->userid)->update($data);
            $response = [
                'doc_file' => !empty($file_url) ? url($file_url) : "",
                'message' => 'success'
            ];
        } else {
            $response = [
                'doc_file' =>  "",
                'message' => 'failed'
            ];
        }
        return response()->json($response);
    }

    public function getInviteCode()
    {
        $response  = User::where('id', $this->userid)->first();
        return response()->json($response);
    }




    public function uploadKycPassportNationalIdCard(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'frontFile_nid' => 'required|image|mimes:jpeg,png,jpg|max:2048',
            'backFile_nid' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        ], [
            'frontFile_nid.required' => 'The front image is required.',
            'frontFile_nid.image' => 'The front file must be an image.',
            'frontFile_nid.mimes' => 'The front image must be a file of type: jpeg, png, jpg.',
            'frontFile_nid.max' => 'The front image may not be greater than 2MB.',

            'backFile_nid.required' => 'The back image is required.',
            'backFile_nid.image' => 'The back file must be an image.',
            'backFile_nid.mimes' => 'The back image must be a file of type: jpeg, png, jpg.',
            'backFile_nid.max' => 'The back image may not be greater than 2MB.',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }


        if (!empty($request->file('frontFile_nid'))) {
            $files = $request->file('frontFile_nid');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['frontFile_nid'] = $file_url;
        }

        if (!empty($request->file('backFile_nid'))) {
            $files = $request->file('backFile_nid');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['backFile_nid'] = $file_url;
        }
        $data['user_id'] = $this->userid;
        Kyc::create($data);

        $response = [
            'message' => 'Your KYC request has been successfully sent. We will review your documents and update you shortly.'
        ];

        return response()->json($response);
    }




    public function uploadKycPassport(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'passportFile' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        ], [
            'passportFile.required' => 'The front image passport is required.',
            'passportFile.image' => 'The front image passport must be an image.',
            'passportFile.mimes' => 'The front image passport must be a file of type: jpeg, png, jpg.',
            'passportFile.max' => 'The front image  passport may not be greater than 2MB.',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }


        if (!empty($request->file('passportFile'))) {
            $files = $request->file('passportFile');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['passport'] = $file_url;
        }

        $data['user_id'] = $this->userid;

        Kyc::create($data);

        $response = [
            'message' => 'Your KYC request has been successfully sent. We will review your documents and update you shortly.'
        ];

        return response()->json($response);
    }

    public function uploadkycDrivLicence(Request $request)
    {


        $validator = Validator::make($request->all(), [
            'dl_front' => 'required|image|mimes:jpeg,png,jpg|max:2048',
            'dl_back' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        ], [
            'dl_front.required' => 'The front image is required.',
            'dl_front.image' => 'The front file must be an image.',
            'dl_front.mimes' => 'The front image must be a file of type: jpeg, png, jpg.',
            'dl_front.max' => 'The front image may not be greater than 2MB.',

            'dl_back.required' => 'The back image is required.',
            'dl_back.image' => 'The back file must be an image.',
            'dl_back.mimes' => 'The back image must be a file of type: jpeg, png, jpg.',
            'dl_back.max' => 'The back image may not be greater than 2MB.',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }


        if (!empty($request->file('dl_front'))) {
            $files = $request->file('dl_front');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['dl_front'] = $file_url;
        }

        if (!empty($request->file('dl_back'))) {
            $files = $request->file('dl_back');
            $fileName = Str::random(20);
            $ext = strtolower($files->getClientOriginalExtension());
            $path = $fileName . '.' . $ext;
            $uploadPath = '/backend/files/';
            $upload_url = $uploadPath . $path;
            $files->move(public_path('/backend/files/'), $upload_url);
            $file_url = $uploadPath . $path;
            $data['dl_back'] = $file_url;
        }

        $data['user_id'] = $this->userid;
        Kyc::create($data);

        $response = [
            'message' => 'Your KYC request has been successfully sent. We will review your documents and update you shortly.'
        ];

        return response()->json($response);
    }



    public function kycRequestApprovedUpdate(Request $request){



        $validator = Validator::make($request->all(), [
            'status' => 'required',
          
        ], [
            'status.required' => 'Status is required.',
       
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }




        $updatedRows = Kyc::where('user_id', $request->id)->update(['status' => 1]);
        return response()->json([
            'success' => true,
            'message' => 'Records updated successfully.',
            'updated_rows' => $updatedRows
        ]);

    }

    public function kycCancel($id)
    {

        $checkKyc = Kyc::find($id);
        $checkKyc->status = 2;
        $checkKyc->save();
        return response()->json([
            'success' => true,
            'message' => 'Has been successfully cancelled.',
            'data'    => $checkKyc
        ]);
    }



    public function checkkycuserrow($id)
    {

        $checkKyc = Kyc::where('user_id', $id)->get();

        $dataList = [];
        foreach ($checkKyc as $v) {
            $passport = !empty($v->passport) ? url($v->passport) : "";  
            $dl_front = !empty($v->dl_front) ? url($v->dl_front) : "";  
            $dl_back  = !empty($v->dl_back) ? url($v->dl_back) : "";  

            $frontFile_nid  = !empty($v->frontFile_nid) ? url($v->frontFile_nid) : "";  
            $backFile_nid   = !empty($v->backFile_nid) ? url($v->backFile_nid) : "";  
           
            // Save data to the array
            $dataList[] = [
                'id'       => $v->id,
                'user_id'  => $v->user_id,
                'passport' => $passport, 
                'dl_front' => $dl_front, 
                'dl_back'  => $dl_back, 
                'frontFile_nid' => $frontFile_nid, 
                'backFile_nid'  => $backFile_nid, 
             
            ];
        }

        return response()->json($dataList, 200);
    }
}
