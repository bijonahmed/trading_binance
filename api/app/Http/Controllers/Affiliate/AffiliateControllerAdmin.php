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
use Illuminate\Support\Facades\Log;
use Session;
use Carbon\Carbon;
use DB;

class AffiliateControllerAdmin extends Controller
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



    public function getLevelAll(Request $request)
    {

        $validator = Validator::make(
            $request->all(),
            ['username' => 'required'],
            ['username.required' => 'The username field is required. Please enter a valid username.']
        );

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $chkrow = User::where('username', $request->username)->first();

        if (!$chkrow) {
            return response()->json(['errors' => 'User not found'], 404);
        }
        $frmDate  = $request->frmDate ?? "2020-01-01";
        $toDate   = $request->toDate ?? "2026-01-01";
        $userId   = $chkrow->id;
        //$email    = $request->email ?? "";
        $frmDate  = $frmDate ?: Carbon::now()->startOfDay()->toDateString(); // Default to today's start date
        $toDate   = $toDate ?: Carbon::now()->endOfDay()->toDateString();   // Default to today's end date

        // Initialize the levels array with the first level (level 1) data
        $levelIds = [$userId];
        $levelsData = [];

        // Loop through the levels (up to 5 levels)
        $totalCount = 0;

        for ($i = 1; $i <= 10; $i++) {
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
        // Return the levels data as a JSON response
        return response()->json([
            'status' => 'success',
            'message' => 'Affiliate report fetched successfully',
            'level_data' => $levelsData,
            'teamCount' => $totalCount, // Assuming level 5 is the last level
        ]);
    }
}
