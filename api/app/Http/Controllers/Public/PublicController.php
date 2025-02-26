<?php

namespace App\Http\Controllers\Public;

use Cart;
use Carbon\Carbon;
use App\Models\Game;
use App\Models\User;
use App\Models\Order;
use App\Models\Videos;
use App\Models\Gallery;
use App\Models\GameList;
use App\Models\GamesAll;
use App\Models\Deposit;
use App\Models\GameType;
//use Darryldecode\Cart\Cart;
use App\Models\ApiConfig;
use App\Models\Categorys;
use App\Models\GameCategory;
use App\Models\GamePlatform;
use App\Models\HostersModel;
use Illuminate\Http\Request;
use App\Models\Chaturbateapi;
use App\Models\GamePlatforms;
use App\Models\MystoreHistory;
use App\Models\VideosThunmnail;
use App\Jobs\ProcessExcelUpload;
use App\Models\GamelistTransate;
use App\Models\GamePlatformOnly;
use App\Http\Controllers\Controller;
use App\Models\ShortVideos;
use App\Models\StarVideoGallerys;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Storage;
use PhpOffice\PhpSpreadsheet\IOFactory;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class PublicController extends Controller
{

   public function gamePltfmAll()
    {
        
        $rows = GamePlatformOnly::where('status',1)->get();
        $data['data']   = $rows;

        return response()->json($data);
    }
	

    public function callbackStatus(Request $request)
    {
        $requestData = $request->all();
        Log::info('Request received from deposit API', $requestData);
        $depositID = $request->depositID;
        $status    = $request->status;
        // Ensure $status is passed as part of an array
        Deposit::where('depositID', $depositID)->update(['status' => $status]);
        return response()->json([
            'msg' => "Successfully updated deposit status",
        ], 200);
    }


    public function getShortVideos(Request $request)
    {

        $page = (int) $request->get('page', 1);
        $perPage = 1;

        // Generate a unique cache key based on relevant query parameters
        $cacheKey = "short_videos:page_{$page}:per_page_{$perPage}";

        // Fetch videos from cache or database
        $videos = Cache::remember($cacheKey, 60, function () use ($page, $perPage) {
            return ShortVideos::where('status', 1)
                ->select(['id', 'files', 'r'])
                ->paginate($perPage, ['*'], 'page', $page);
        });

        // Prepare the result
        $videosData = $videos->map(function ($video) {
            return [
                'id' => $video->id,
                //'files' => url($video->r), // Directly set the path
                'files' => $video->files, // Directly set the path
            ];
        });

        // Return JSON response
        return response()->json([
            'data' => $videosData,
            'current_page' => $videos->currentPage(),
            'last_page' => $videos->lastPage(),
        ]);

        // // Current page
        // $page = $request->get('page', 1);
        // $perPage = 1;

        // // Cache key based on the full URL to handle any query params
        // $cacheKey = "short_videos_{$request->fullUrl()}";

        // // Check if the response is cached
        // $videos = Cache::remember($cacheKey, 60, function () use ($page, $perPage) {
        //     // Fetch paginated videos in random order
        //     return ShortVideos::where('status', 1)
        //         ->inRandomOrder() // Randomize at the database level
        //         ->paginate($perPage, ['id', 'files', 'r'], 'page', $page);
        // });

        // // Prepare the result
        // $result = $videos->map(function ($video) {
        //     return [
        //         'id' => $video->id,
        //         //'files' => file_exists(public_path($video->r)) ? url($video->r) : "", // Check if file exists
        //         'files' => '/backend/files/'.$video->files, // Check if file exists
        //     ];
        // });

        // // Return the response with current page info
        // return response()->json([
        //     'data' => $result,
        //     'current_page' => $videos->currentPage(),
        //     'last_page' => $videos->lastPage(),
        // ]);
    }

    public function pltformWiseGame(Request $request)
    {

        $slug = $request->slug ?? "";
        $data = GameList::where('platType', $slug)->orderBy('id', 'desc')->get();
        $result = [];
        foreach ($data as $key => $v) {
            $result[] = [
                'id'    => $v->id,
                'name'  => $v->gameName_en,
                'slug'  => $v->platType,
                'image' => !empty($v->game_images) ? url($v->game_images) : "",
            ];
        }
        return response()->json([
            'count' => count($data),
            'data'  => $result,
        ], 200);
    }

    public function getonlyPltform()
    {

        $data = GamePlatformOnly::orderBy('name', 'asc')->where('status', 1)->get();
        $result = [];
        foreach ($data as $key => $v) {
            $result[] = [
                'id'    => $v->id,
                'name'  => $v->name,
                'slug'  => $v->slug,
                'image' => !empty($v->image) ? url($v->image) : "",
            ];
        }
        return response()->json([
            'data' => $result,
        ], 200);
    }

    public function getPornStarPics(Request $request)
    {

        //dd($request->all());
        // Directory path
        $directory = public_path('backend/files/model');
        $files = File::files($directory);

        // Pagination parameters
        $page = $request->input('page', 1); // Default page is 1
        $limit = $request->input('limit', 56); // Default limit is 50

        // Filter files based on search query (optional)
        $searchQuery = $request->input('query');
        $filteredFiles = array_filter($files, function ($file) use ($searchQuery) {
            $fileName = $file->getFilename();
            return empty($searchQuery) || stripos($fileName, $searchQuery) !== false;
        });

        // Total number of filtered files
        $totalFiles = count($filteredFiles);
        $totalPages = ceil($totalFiles / $limit);

        // Offset for the current page
        $offset = ($page - 1) * $limit;
        $pagedFiles = array_slice($filteredFiles, $offset, $limit);

        // Prepare file URLs
        $fileUrls = array_map(function ($file) {
            return url('/backend/files/model/' . $file->getFilename());
        }, $pagedFiles);

        // Return paginated response
        return response()->json([
            'data' => $fileUrls,
            'total_pages' => $totalPages,
        ]);
    }

    public function getPornStarVideos(Request $request)
    {

        $page = $request->input('page', 1); // Default page is 1
        $limit = $request->input('limit', 56); // Default limit is 56

        // Pagination query using paginate()
        $data = StarVideoGallerys::paginate($limit);

        // Return paginated response
        return response()->json([
            'data' => $data->items(), // Paginated items
            'total_pages' => $data->lastPage(), // Total pages available
            'current_page' => $data->currentPage(), // Current page
            'total_items' => $data->total(), // Total number of items
        ]);
    }

    public function filterGames(Request $request)
    {

        $search         = $request->input('search', '');
        $platformId     = $request->input('platformId', '');
        $gameTypeId     = $request->input('gameTypeId', '');
        $gamesQuery     = GamesAll::query();
        // Apply search filter
        if ($search) {
            $gamesQuery->where('name', 'like', '%' . $search . '%');
        }
        // Apply platform filter
        if ($platformId) {
            $gamesQuery->where('platform_id', $platformId);
        }

        // Apply game type filter
        if ($gameTypeId) {
            $gamesQuery->where('gametype_id', $gameTypeId);
        }
        // Get the filtered games
        $allGames = $gamesQuery->get();

        $dataList = [];
        foreach ($allGames as $v) {
            $chkGameTrans = GamelistTransate::where('gameid', $v->gameid)->first();
            $dataList[] = [
                'id'            => $v->id,
                'name'          => $v->name,
                'translate_name' => !empty($chkGameTrans) ? $chkGameTrans->name : "",
                'slug'          => $v->slug,
                'game_type'     => $v->game_type,
                'gameid'        => $v->gameid,
                'imagepath'     => !empty($v->game_images) ? url($v->game_images) : "", // Path for the image
                'status'        => $v->status,
            ];
        }
        return response()->json([
            'gameTypeName' => "",
            'success' => true,
            'message' => 'Games fetched successfully.',
            'data'    => $dataList,
        ], 200);
    }

    public function gameCategoryGame(Request $request)
    {

        //  try {
        $slug       = !empty($request->slug) ? $request->slug : "";
        $language   = !empty($request->language) ? $request->language : "";
        //  dd($request->all());
        $row        = !empty($gameName) ? $gameName->name : "";
        $gameName   = GamesAll::where('slug', $slug)->first();
        //$allGames = GamesAll::where('code', $slug)->get();

        $allGames   = GamesAll::where('api_gamelist.slug', $slug)
            //    ->join('api_gamelist_transate', 'api_gamelist.game_code', '=', 'api_gamelist_transate.game_code')
            ->select('api_gamelist.*')
            // ->where('api_gamelist_transate.language', $language)
            ->where('api_gamelist.status', 1)->orderBy('api_gamelist.id', 'desc')->get();

        // Prepare the response data
        $data['allGames'] = $allGames;
        $data['gameName'] = $row;

        // Return the success JSON response
        return response()->json([
            'success' => true,
            'message' => 'Games fetched successfully',
            'data'    => $data,
        ], 200);
    }

    public function checkVideoAppId(Request $request)
    {

        $api_id = $request->api_id;
        $data   = Videos::where('api_id', $api_id)->first();
        return response()->json([
            'success'     => true,
            'data'        => $data,

        ], 200);
    }

    public function checkGameData(Request $request)
    {
        $data          = GamesAll::where('id', $request->slug)->first();
        $game_images   = !empty($data) ? url($data->game_images) : "";
        try {
            return response()->json([
                'success'     => true,
                'game_images' => $game_images,
                'data'        => $data,

            ], 200);
        } catch (\Exception $e) {
            // Handle any errors and return an error JSON response
            return response()->json([
                'success' => false,
                'message' => 'An error occurred: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function getPublicAllGames()
    {

        $allGames   = GamesAll::where('status', 1)
            ->select('api_gamelist.*')
            ->where('api_gamelist.status', 1)->orderBy('api_gamelist.id', 'desc')->get();

        //  dd($allGames);
        try {
            $dataList = [];
            foreach ($allGames as $v) {
                $chkGameTrans = GamelistTransate::where('gameid', $v->gameid)->first();
                $dataList[] = [
                    'id'            => $v->id,
                    'name'          => $v->name,
                    'translate_name' => !empty($chkGameTrans) ? $chkGameTrans->name : "",
                    'slug'          => $v->slug,
                    'game_type'     => $v->game_type,
                    'gameid'        => $v->gameid,
                    'imagepath'     => !empty($v->game_images) ? url($v->game_images) : "", // Path for the image
                    'status'        => $v->status,
                ];
            }
            // Return success response with the fetched categories
            return response()->json([
                'gameTypeName' => !empty($slugSearch) ? $slugSearch->name : "",
                'success' => true,
                'message' => 'Games fetched successfully.',
                'data'    => $dataList,
            ], 200);
        } catch (\Exception $e) {
            // Return error response with the exception message
            return response()->json([
                'gameTypeName' => "",
                'success'      => false,
                'message'      => 'An error occurred: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function getAllGames($slug)
    {
        // $language = $request->language;
        // $slug     = $request->slug;
        $slugSearch    = GameType::where('slug', $slug)->where('status', 1)->first();
        $gametypeCode  = !empty($slugSearch) ? $slugSearch->gameTypecode : "";
        // $allGames      = GamesAll::where('game_type', $gametypeCode)->orderBy('id', 'desc')->paginate(48); // Set the limit here
        $allGames      = GamesAll::where('game_type', $gametypeCode)
            ->join('api_gamelist_transate', 'api_gamelist.game_code', '=', 'api_gamelist_transate.game_code')
            ->select('api_gamelist.*', 'api_gamelist_transate.name as translate_name', 'api_gamelist_transate.language')
            //->where('api_gamelist_transate.language', $language)
            ->where('api_gamelist.status', 1)->orderBy('api_gamelist.id', 'desc')->paginate(48);

        try {
            $dataList = [];
            foreach ($allGames as $v) {
                $dataList[] = [
                    'id'            => $v->id,
                    'name'          => $v->name,
                    'code'          => $v->code,
                    'game_code'     => $v->game_code,
                    'game_type'     => $v->game_type,
                    'translate_name' => $v->translate_name,
                    'imagepath'     => $v->img,
                    'slug'          => $v->slug,
                    'status'        => $v->status,
                ];
            }

            return response()->json([
                'gameTypeName' => !empty($slugSearch) ? $slugSearch->name : "",
                'success'      => true,
                'message'      => 'Games fetched successfully.',
                'data'         => $dataList,
                'last_page'    => $allGames->lastPage(), // Add total pages
                'current_page' => $allGames->currentPage(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'gameTypeName' => "",
                'success'      => false,
                'message'      => 'An error occurred: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function categoryWiseGames(Request $request)
    {

        $language = $request->language;
        $slug     = $request->slug;

        $slugSearch    = GamePlatform::where('slug', $slug)->where('status', 1)->first();
        $platformId    = !empty($slugSearch) ? $slugSearch->id : "";
        $allGames      = GamesAll::where('platform_id', $platformId)
            // ->join('api_gamelist_transate', 'api_gamelist.gameid', '=', 'api_gamelist_transate.gameid')
            //->select('api_gamelist.*', 'api_gamelist_transate.name as translate_name', 'api_gamelist_transate.language')
            ->select('api_gamelist.*')
            //->where('api_gamelist_transate.language', $language)
            ->where('api_gamelist.status', 1)->orderBy('api_gamelist.id', 'desc')->limit(20)->get();

        //  dd($allGames);
        try {
            $dataList = [];
            foreach ($allGames as $v) {

                $chkGameTrans = GamelistTransate::where('gameid', $v->gameid)->first();
                // $imagePath = url($v->image);
                $dataList[] = [
                    'id'            => $v->id,
                    'name'          => $v->name,
                    'translate_name' => !empty($chkGameTrans) ? $chkGameTrans->name : "",
                    'slug'          => $v->slug,
                    'game_type'     => $v->game_type,
                    'gameid'        => $v->gameid,
                    'imagepath'     => !empty($v->game_images) ? url($v->game_images) : "", // Path for the image
                    'status'        => $v->status,
                ];
            }
            // Return success response with the fetched categories
            return response()->json([
                'gameTypeName' => !empty($slugSearch) ? $slugSearch->name : "",
                'success' => true,
                'message' => 'Categories fetched successfully.',
                'data'    => $dataList,
            ], 200);
        } catch (\Exception $e) {
            // Return error response with the exception message
            return response()->json([
                'gameTypeName' => "",
                'success'      => false,
                'message'      => 'An error occurred: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function gameTypeWisePlatformList(Request $request)
    {
      
        $game_type_id  = $request->game_type_id ?? "";
        $gameTyperow   = GameType::where('id', $game_type_id)->where('status', 1)->first();


        $query  = GamePlatform::where('game_type_id', $game_type_id)->where('status', 1);
        if ($request->has('slug')) {
            //$query->where('slug', 'LIKE', '%' . $request->searchText . '%');
            $query->where('slug', $request->slug );
        }
        
        
        $platformrows = $query->get();
        //dd($platformrows);

        $dataList = [];
        foreach ($platformrows as $v) {
            $imagePath = !empty($v->image) ? url($v->image) : "";
            $dataList[] = [
                'id'            => $v->id,
                'name'          => $v->name,
                'slug'          => $v->slug,
                'status'        => $v->status,
                'imagepath'     => $imagePath, // Path for the image
            ];
        }
        // Return success response with the fetched categories
        return response()->json([
            'gameType_name' => !empty($gameTyperow) ? $gameTyperow->name : "",
            'success' => true,
            'message' => 'Fetched successfully.',
            'data'    => $dataList,
        ], 200);
    }

    public function gameTypeWiseCategory($slug)
    {
        // Fetch the GameType based on the slug
        $platformrow  = GamePlatform::where('slug', $slug)->where('status', 1)->first();
        $platformid   = !empty($platformrow) ? $platformrow->id : "";
        $getPlatforms = GameList::where('platform_id', $platformid)->get();

        $dataList = [];
        foreach ($getPlatforms as $v) {
            $imagePath = !empty($v->game_images) ? url($v->game_images) : "";
            $dataList[] = [
                'id'            => $v->id,
                'code'          => $v->code,
                'name'          => $v->name,
                'game_type'     => !empty($platformrow) ? $platformrow->name : "",
                'slug'          => $v->slug,
                'status'        => $v->status,
                'imagepath'     => $imagePath, // Path for the image
            ];
        }
        // Return success response with the fetched categories
        return response()->json([
            'platform_name' => !empty($platformrow) ? $platformrow->name : "",
            'success' => true,
            'message' => 'Categories fetched successfully.',
            'data'    => $dataList,
        ], 200);
    }

    public function allGamesTypes()
    {
        $result = GameType::where('status', 1)
            ->orderBy('gameTypeCode', 'asc')
            ->get();

        $dataList = [];
        foreach ($result as $v) {
            $imagePath = !empty($v->image) ? url($v->image) : "";
            $dataList[] = [
                'id'            => $v->id,
                'gameTypecode'  => $v->gameTypecode,
                'name'          => $v->name,
                'game_type'     => !empty($platformrow) ? $platformrow->name : "",
                'slug'          => $v->slug,
                'status'        => $v->status,
                'imagepath'     => $imagePath, // Path for the image
            ];
        }
        // Return success response with the fetched categories
        return response()->json([
            'success' => true,
            'message' => 'Fetched successfully.',
            'data'    => $dataList,
        ], 200);
    }

    public function htmlIframeCode()
    {
        try {
            // Assume you might fetch the URL from a database or some logic here
            $url = 'https://chaturbate.com/in/?tour=Jrvi&amp;campaign=mJxqA&amp;track=embed&amp;room=carter_reos&amp;bgcolor=white';

            return response()->json([
                'url' => $url
            ]);
        } catch (\Exception $e) {
            // Handle any exceptions that might occur
            return response()->json([
                'error' => 'Failed to retrieve iframe URL.',
                'message' => $e->getMessage() // Log or display error message as needed
            ], 500); // Return a 500 internal server error code
        }
    }

    public function getAllVideos(Request $request)
    {

        $perPage = 100; // Number of records per page
        $page = $request->input('page', 1); // Current page number
        // Fetch the paginated records
        $recordsRows = Videos::where('status', 1)
            ->inRandomOrder()
            ->paginate($perPage, ['*'], 'page', $page); // Specify the page number explicitly
        return response()->json($recordsRows, 200);
    }

    public function getAllHosters(Request $request)
    {
        $perPage = 100; // Number of records per page
        $page = $request->input('page', 1); // Current page number

        // Fetch the paginated records
        $recordsRows = HostersModel::where('status', 1)
            ->paginate($perPage, ['*'], 'page', $page); // Specify the page number explicitly
        return response()->json($recordsRows, 200);
    }

    public function getMobileAllHosters(Request $request)
    {
        $perPage = 10; // Number of records per page
        $page = $request->input('page', 1); // Current page number

        // Fetch the paginated records
        $recordsRows = HostersModel::where('status', 1)
            ->paginate($perPage, ['*'], 'page', $page); // Specify the page number explicitly
        return response()->json($recordsRows, 200);
    }

    public function galleryApiData()
    {

        $recordsRows = Gallery::where('status', 1)->inRandomOrder()->get();
        $dataList = [];
        foreach ($recordsRows as $v) {
            $imagePath = url($v->image_path);
            $row       = Videos::Where('video_id', $v->video_id)->first();
            // Save data to the array
            $dataList[] = [
                'id'        => $v->id,
                'api_id'    => !empty($row->api_id) ? $row->api_id : "",
                'imagepath' => $imagePath, // Path for the image
            ];
        }

        return response()->json($dataList, 200);
    }
    public function checkHosterProfile($slug)
    {

        $row         = Videos::where('video_id', $slug)->first();
        $video_id    = !empty($row->video_id) ? $row->video_id : "";
        $history     = VideosThunmnail::where('video_id', $video_id)->get();
        $data['row']     = $row;
        $data['gallary'] = $history;

        return response()->json($data);
    }

    public function checkLiveHosterProfile($slug)
    {

        $row         = Chaturbateapi::where('username', $slug)->first();
        $data['row']     = $row;
        $data['gallary'] = "";

        return response()->json($data);
    }

    public function getAllCaegorys(Request $request)
    {
        $language = $request->get('language', 'en');
        $categories = Categorys::where('parent_id', 0)->where('language', $language)->get();
        return response()->json($categories);
    }

    public function getCategorySlug($slug, Request $request)
    {

        $categories = Categorys::where('slug', $slug)->first();

        if (!$categories) {
            return response()->json(['message' => 'Category not found'], 404);
        }

        $filtertxtName = $categories->name ? $categories->name : '';
        $perPage       = $request->input('per_page', 50); // Default value is 50
        $result        = Videos::where('category', 'like', '%' . $filtertxtName . '%')
            ->paginate($perPage); // Use dynamic pagination

        return response()->json($result);
    }

    public function upload()
    {

        return view('upload');
    }

    public function uploadFile(Request $request)
    {
        // Validate the uploaded file
        $request->validate([
            'file' => 'required|file|max:102400', // Max file size is 100MB
        ]);

        // Assuming you have logic to process the uploaded Excel file
        // and you extract the rows of video data into an array.

        $videoRows = []; // Replace this with your actual logic to extract data from the Excel file

        foreach ($videoRows as $row) {
            // Dispatch the job with the video data
            InsertVideoJob::dispatch([
                'video_id' => $row[0],
                'category' => $row[1],
                'api_id' => $row[2],
                'title' => $row[3],
                'url' => $row[4],
                'slug' => $row[5],
                'thumb_src' => $row[6],
                'thumb_size' => $row[7],
                'page' => $row[8],
                'keywords' => $row[9],
                'length_sec' => $row[10],
                'length_min' => $row[11],
                'embed' => $row[12],
                'status' => $row[13],
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        return back()->with('success', 'Upload successful! Videos are being processed.');
    }

    public function allGames(Request $request)
    {
       // $result = GamesAll::where('status', 1)->get();
       // return response()->json($result);
       $query = GamesAll::where('status', 1);

       if ($request->has('gameName_en')) {
           $query->where('gameName_en', 'LIKE', '%' . $request->gameName_en . '%');
       }
   
       $result = $query->get();
   
       return response()->json($result);
    }
}