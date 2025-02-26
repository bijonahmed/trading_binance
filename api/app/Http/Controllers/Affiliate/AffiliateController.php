<?php

namespace App\Http\Controllers\Affiliate;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Auth;
use Validator;
use Helper;
use App\Models\Holiday;
use App\Models\User;
use App\Models\Manufactures;
use App\Models\Brands;
use App\Models\Community;
use Illuminate\Support\Str;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;
use Session;
use Carbon\Carbon;
use DB;

class AffiliateController extends Controller
{
    protected $userid;
    public function __construct()
    {

        $id = auth('api')->user();

        $this->middleware('auth:api');
        $id = auth('api')->user();
        if (!empty($id->id)) {
            $user = User::find($id->id);
            $this->userid = $user->id;
        }
    }

    public function makeAffilaiteReport(Request $request)
    {
        //dd($request->all());
        $level = $request->level ?? "";

        $methods = [
            0 => 'getLevelAll',
            1 => 'getLevelOne',
            2 => 'getLevelTwo',
            3 => 'getLevelThree',
            4 => 'getLeveltFour',
            5 => 'getLeveltFive'
        ];

        return isset($methods[$level]) ? $this->{$methods[$level]}($request) : null;

    }

    public function getLevelAll($request)
    {
        // dd($request->all());
        $level    = $request->level;
        $frmDate  = $request->frmDate ?? "2020-01-01";
        $toDate   = $request->toDate ?? "2030-01-01";
        $userId   = $this->userid;
        $email    = $request->email ?? "";
        $frmDate  = $frmDate ?: Carbon::now()->startOfDay()->toDateString(); // Default to today's start date
        $toDate   = $toDate ?: Carbon::now()->endOfDay()->toDateString();   // Default to today's end date

        // Initialize the levels array with the first level (level 1) data
        $levelIds = [$userId];
        $levelsData = [];

        // Loop through the levels (up to 5 levels)
        $totalCount = 0;

        for ($i = 1; $i <= 5; $i++) {
            // Fetch data for the current level based on ref_id
            $levelsData[$i] = User::whereIn('ref_id', $levelIds)
                ->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', 'ref_id', DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as createdat"))
                ->when($frmDate && $toDate, function ($query) use ($frmDate, $toDate) {
                    return $query->whereBetween(DB::raw('DATE(created_at)'), [$frmDate, $toDate]);
                })
                ->get();

            // Add reference name for each user in the current level
            foreach ($levelsData[$i] as $user) {
                $chkRefName = User::where('id', $user->ref_id)->select('username')->first();
                $user->ref_name = $chkRefName ? $chkRefName->username : null;  // Add ref_name to the user data
            }

            // Update levelIds to be the IDs of users in the current level
            $levelIds = $levelsData[$i]->pluck('id')->toArray();

            // Increment the total count by the number of users in the current level
            $totalCount += $levelsData[$i]->count();
        }

        // Now $totalCount contains the total number of rows (users) across all levels

        // Return the levels data as a JSON response
        return response()->json([
            'status' => 'success',
            'message' => 'Affiliate report fetched successfully',
            'level_data' => $levelsData,
            'teamCount' => $totalCount, // Assuming level 5 is the last level
        ]);
    }


    public function getLevelOne($request)
    {
        $level    = $request->level;
        $frmDate  = $request->frmDate ?? "";
        $toDate   = $request->toDate ?? "";
        $userId   = $this->userid;
        $email    = $request->email ?? "";
        $frmDate  = $frmDate ?: Carbon::now()->startOfDay()->toDateString(); // Default to today's start date
        $toDate   = $toDate ?: Carbon::now()->endOfDay()->toDateString();   // Default to today's end date
        //echo "userID: {$userId}--FrmDate {$frmDate}---ToDate {$toDate}";
        //exit;

        $query     = User::where('ref_id', $userId)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as createdat"), 'ref_id');

        if ($frmDate && $toDate) {
            $query->whereBetween(DB::raw('DATE(created_at)'), [$frmDate, $toDate]);
        }

        $checkL1 = $query->get();
        $arryData = [];
        foreach ($checkL1 as $v) {
            $chkRefName = User::where('id', $v->ref_id)->select('id', 'username')->first();
            $arryData[] = [
                'id'                   => $v->id,
                'fg_id'                => $v->fg_id,
                'inviteCode'           => $v->inviteCode,
                'name'                 => $v->name,
                'username'             => $v->username,
                'createdat'            => $v->createdat,
                'ref_id'               => $v->ref_id,
                'ref_name'             => $chkRefName->username ?? "",
            ];
        }

        return response()->json([
            'level_data'  => $arryData,
            'teamCount'   => count($checkL1),
            'usdt'        => 10,
        ]);
    }


    public function getLevelTwo(Request $request)
    {
        $level    = $request->level;
        $frmDate  = $request->frmDate ?? "";
        $toDate   = $request->toDate ?? "";
        $userId   = $this->userid;
        $email    = $request->email ?? "";
        $frmDate  = $frmDate ?: Carbon::now()->startOfDay()->toDateString(); // Default to today's start date
        $toDate   = $toDate ?: Carbon::now()->endOfDay()->toDateString();   // Default to today's end date

        $checkL1          = User::where('ref_id', $userId)->select('id')->get();
        $level1_ids       = $checkL1->pluck('id')->toArray();

        $query            = User::whereIn('ref_id', $level1_ids)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as createdat"), 'ref_id');
        // if ($email) {
        //     $query->where('email', 'like', '%' . $email . '%');
        // }

        if ($frmDate && $toDate) {
            $query->whereBetween(DB::raw('DATE(created_at)'), [$frmDate, $toDate]);
        }

        $checkL1 = $query->get();
        $arryData = [];
        foreach ($checkL1 as $v) {
            $chkRefName = User::where('id', $v->ref_id)->select('id', 'username')->first();
            $arryData[] = [
                'id'                   => $v->id,
                'fg_id'                => $v->fg_id,
                'inviteCode'           => $v->inviteCode,
                'name'                 => $v->name,
                'username'             => $v->username,
                'createdat'            => $v->createdat,
                'ref_id'               => $v->ref_id,
                'ref_name'             => $chkRefName->username ?? "",
            ];
        }


        return response()->json([
            'level_data'  => $arryData,
            'teamCount'   => count($checkL1),
            'usdt'        => 15400,
        ]);
    }


    public function getLevelThree(Request $request)
    {
        $level    = $request->level;
        $frmDate  = $request->frmDate ?? "";
        $toDate   = $request->toDate ?? "";
        $userId   = $this->userid;
        $email    = $request->email ?? "";
        $frmDate  = $frmDate ?: Carbon::now()->startOfDay()->toDateString(); // Default to today's start date
        $toDate   = $toDate ?: Carbon::now()->endOfDay()->toDateString();   // Default to today's end date

        $levelIds = [$userId];
        $levelsData = [];
        for ($i = 1; $i <= 2; $i++) {
            $levelsData[$i] = User::whereIn('ref_id', $levelIds)->select('id')->get();
            $levelIds = $levelsData[$i]->pluck('id')->toArray(); // Update levelIds for next iteration
        }

        $query  = User::whereIn('ref_id', $levelIds)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as createdat"), 'ref_id');


        if ($frmDate && $toDate) {
            $query->whereBetween(DB::raw('DATE(created_at)'), [$frmDate, $toDate]);
        }

        $checkL1 = $query->get();
        $arryData = [];
        foreach ($checkL1 as $v) {
            $chkRefName = User::where('id', $v->ref_id)->select('id', 'username')->first();
            $arryData[] = [
                'id'                   => $v->id,
                'fg_id'                => $v->fg_id,
                'inviteCode'           => $v->inviteCode,
                'name'                 => $v->name,
                'username'             => $v->username,
                'createdat'            => $v->createdat,
                'ref_id'               => $v->ref_id,
                'ref_name'             => $chkRefName->username ?? "",
            ];
        }
        return response()->json([
            'level_data'  => $arryData,
            'teamCount'   => count($checkL1),
            'usdt'        => 15400,
        ]);
    }


    public function getLeveltFour(Request $request)
    {
        $level    = $request->level;
        $frmDate  = $request->frmDate ?? "";
        $toDate   = $request->toDate ?? "";
        $userId   = $this->userid;
        $email    = $request->email ?? "";
        $frmDate  = $frmDate ?: Carbon::now()->startOfDay()->toDateString(); // Default to today's start date
        $toDate   = $toDate ?: Carbon::now()->endOfDay()->toDateString();   // Default to today's end date

        // Get all levels in a loop to avoid repetition
        $levelIds = [$userId];
        $levelsData = [];
        for ($i = 1; $i <= 3; $i++) {
            $levelsData[$i] = User::whereIn('ref_id', $levelIds)->select('id')->get();
            $levelIds = $levelsData[$i]->pluck('id')->toArray(); // Update levelIds for next iteration
        }
        // Final query for Level 5
        $query            = User::whereIn('ref_id', $levelIds)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as createdat"), 'ref_id');
        // if ($email) {
        //     $query->where('email', 'like', '%' . $email . '%');
        // }

        if ($frmDate && $toDate) {
            $query->whereBetween(DB::raw('DATE(created_at)'), [$frmDate, $toDate]);
        }

        $checkL1 = $query->get();
        $arryData = [];
        foreach ($checkL1 as $v) {
            $chkRefName = User::where('id', $v->ref_id)->select('id', 'username')->first();
            $arryData[] = [
                'id'                   => $v->id,
                'fg_id'                => $v->fg_id,
                'inviteCode'           => $v->inviteCode,
                'name'                 => $v->name,
                'username'             => $v->username,
                'createdat'            => $v->createdat,
                'ref_id'               => $v->ref_id,
                'ref_name'             => $chkRefName->username ?? "",
            ];
        }
        return response()->json([
            'level_data'  => $arryData,
            'teamCount'   => count($checkL1),
            'usdt'        => 15400,
        ]);
    }


    public function getLeveltFive(Request $request)
    {
        $level    = $request->level;
        $frmDate  = $request->frmDate ?? "";
        $toDate   = $request->toDate ?? "";
        $userId   = $this->userid;
        $email    = $request->email ?? "";
        $frmDate  = $frmDate ?: Carbon::now()->startOfDay()->toDateString(); // Default to today's start date
        $toDate   = $toDate ?: Carbon::now()->endOfDay()->toDateString();   // Default to today's end date

        // Get all levels in a loop to avoid repetition
        $levelIds = [$userId];
        $levelsData = [];
        for ($i = 1; $i <= 4; $i++) {
            $levelsData[$i] = User::whereIn('ref_id', $levelIds)->select('id')->get();
            $levelIds = $levelsData[$i]->pluck('id')->toArray(); // Update levelIds for next iteration
        }
        // Final query for Level 5
        $query = User::whereIn('ref_id', $levelIds)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as createdat"), 'ref_id');


        if ($frmDate && $toDate) {
            $query->whereBetween(DB::raw('DATE(created_at)'), [$frmDate, $toDate]);
        }
        $checkL1 = $query->get();
        $arryData = [];
        foreach ($checkL1 as $v) {
            $chkRefName = User::where('id', $v->ref_id)->select('id', 'username')->first();
            $arryData[] = [
                'id'                   => $v->id,
                'fg_id'                => $v->fg_id,
                'inviteCode'           => $v->inviteCode,
                'name'                 => $v->name,
                'username'             => $v->username,
                'createdat'            => $v->createdat,
                'ref_id'               => $v->ref_id,
                'ref_name'             => $chkRefName->username ?? "",
            ];
        }

        return response()->json([
            'level_data'  => $arryData,
            'teamCount'   => count($checkL1),
            'usdt'        => 15400,
        ]);
    }


    public function getLeveltFivebackup(Request $request)
    {
        $level    = $request->level;
        $frmDate  = $request->frmDate ?? "";
        $toDate   = $request->toDate ?? "";
        $userId   = $this->userid;
        $email    = $request->email ?? "";
        $frmDate  = $frmDate ?: Carbon::now()->startOfDay()->toDateString(); // Default to today's start date
        $toDate   = $toDate ?: Carbon::now()->endOfDay()->toDateString();   // Default to today's end date

        // $checkL1          = User::where('ref_id', $userId)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', 'created_at', 'ref_id')->get();
        // $level1_ids       = $checkL1->pluck('id')->toArray();

        // $checkL2          = User::whereIn('ref_id', $level1_ids)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', 'created_at', 'ref_id')->get();
        // $level2_ids       = $checkL2->pluck('id')->toArray();

        // $checkL3            = User::whereIn('ref_id', $level2_ids)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', 'created_at', 'ref_id');
        // $level3_ids       = $checkL3->pluck('id')->toArray();

        // $checkL4            = User::whereIn('ref_id', $level3_ids)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', 'created_at', 'ref_id');
        // $level4_ids       = $checkL4->pluck('id')->toArray();

        //$query            = User::whereIn('ref_id', $level4_ids)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', 'created_at', 'ref_id');

        // if ($email) {
        //     $query->where('email', 'like', '%' . $email . '%');
        // }

        // Get all levels in a loop to avoid repetition
        $levelIds = [$userId];
        $levelsData = [];
        for ($i = 1; $i <= 4; $i++) {
            $levelsData[$i] = User::whereIn('ref_id', $levelIds)->select('id')->get();
            $levelIds = $levelsData[$i]->pluck('id')->toArray(); // Update levelIds for next iteration
        }
        // Final query for Level 5
        $query = User::whereIn('ref_id', $levelIds)->select('id', 'fg_id', 'inviteCode', 'name', 'username', 'email', DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d') as createdat"), 'ref_id');


        if ($frmDate && $toDate) {
            $query->whereBetween(DB::raw('DATE(created_at)'), [$frmDate, $toDate]);
        }
        $checkL1 = $query->get();
        $arryData = [];
        foreach ($checkL1 as $v) {
            $chkRefName = User::where('id', $v->ref_id)->select('id', 'username')->first();
            $arryData[] = [
                'id'                   => $v->id,
                'fg_id'                => $v->fg_id,
                'inviteCode'           => $v->inviteCode,
                'name'                 => $v->name,
                'username'             => $v->username,
                'createdat'            => $v->createdat,
                'ref_id'               => $v->ref_id,
                'ref_name'             => $chkRefName->username ?? "",
            ];
        }

        return response()->json([
            'level_data'  => $arryData,
            'teamCount'   => count($checkL1),
            'usdt'        => 15400,
        ]);
    }

    // public function getLevelThreeDetails(Request $request)
    // {
    //     $userId           = $this->userid;
    //     $email            = $request->email;
    //     $frmDate          = $request->frmDate;
    //     $toDate           = $request->toDate;

    //     $checkL1          = User::where('ref_id', $userId)->select('id', 'ocn_id', 'ocn_address', 'name', 'email', 'created_at', 'ref_id')->get();
    //     $level1_ids       = $checkL1->pluck('id')->toArray();

    //     $checkL2          = User::whereIn('ref_id', $level1_ids)->select('id', 'name', 'email', 'created_at', 'ref_id')->get();
    //     $level2_ids       = $checkL2->pluck('id')->toArray();
    //     $query            = User::whereIn('ref_id', $level2_ids)->select('id', 'ocn_id', 'ocn_address', 'name', 'email', 'created_at', 'ref_id');

    //     if ($email) {
    //         $query->where('email', 'like', '%' . $email . '%');
    //     }

    //     if ($frmDate && $toDate) {
    //         $query->whereBetween('created_at', [$frmDate, $toDate]);
    //     } elseif ($frmDate) {
    //         $query->where('created_at', '>=', $frmDate);
    //     } elseif ($toDate) {
    //         $query->where('created_at', '<=', $toDate);
    //     }

    //     $checkL1 = $query->get();
    //     return response()->json([
    //         'level_data'  => $checkL1,
    //         'teamCount'   => count($checkL1),
    //         'usdt'        => 15400,
    //     ]);
    // }


}
