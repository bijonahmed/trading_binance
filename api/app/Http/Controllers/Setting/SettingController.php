<?php

namespace App\Http\Controllers\Setting;

use App\Http\Controllers\Controller;
use App\Models\AddCountry;
use App\Models\Countrys;
use App\Models\CountryWiseBank;
use App\Models\Currency;
use App\Models\Language;
use App\Models\Profile;
use App\Models\Setting;
use App\Models\Sliders;
use App\Models\Translation;
use App\Models\User;

use Auth;
use DB;
use Helper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Validator;

class SettingController extends Controller
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



    public function getSelectedBank(Request $request)
    {


        $id         = $request->countryWiseBankId ?? "";
        $countryId  = $request->countryId ?? "";

        $row       = CountryWiseBank::select(
            'country_id',
            'bank_name',
            'account_name',
            'account_number',
            'ific_code',
            'swift_code',
            'others_code'
        )
            ->where('country_wise_bank.id', $id)
            ->where('country_wise_bank.country_id', $countryId)
            ->where('country_wise_bank.status', 1)->first();

        $chkCountry  =    AddCountry::where('country_id', $row->country_id)->where('status', 1)->first();
        $chkCurrency =    Currency::where('id', $chkCountry->currency_id)->first();

        $data = [
            'bank_name'      => $row->bank_name ?? '',
            'account_name'   => $row->account_name ?? '',
            'account_number' => $row->account_number ?? '',
            'ific_code'      => $row->ific_code ?? '',
            'swift_code'     => $row->swift_code ?? '',
            'others_code'    => $row->others_code ?? '',
            'usdt_rate'      => $chkCountry->usdt_rate ?? '',
            'currencyName'   => $chkCurrency->name ?? '',
            'currencySymbol' => $chkCurrency->symbol ?? ''

        ];

        return response()->json([
            'data' => $data,
            'message' => 'success'
        ], 200);
    }

    public function getAllBankList(Request $request)
    {

        $country_id = $request->country_id ?? "";
        $rows       = CountryWiseBank::where('country_id', $country_id)->where('status', 1)->get();
        return response()->json([
            'data' => $rows,
            'message' => 'success'
        ], 200);
    }


    public function getCountryBankList()
    {

        $rows = CountryWiseBank::leftJoin('add_country', 'add_country.country_id', '=', 'country_wise_bank.country_id')
            ->leftJoin('country', 'add_country.country_id', '=', 'country.id')
            ->leftJoin('currency', 'add_country.currency_id', '=', 'currency.id')
            ->select(
                'country_wise_bank.id',
                'add_country.currency_id',
                'add_country.country_id',
                'add_country.usdt_rate',
                'country_wise_bank.bank_name',
                'country_wise_bank.account_name',
                'country_wise_bank.account_number',
                'country_wise_bank.ific_code',
                'currency.symbol as currency_symbol',
                'country_wise_bank.swift_code',
                'currency.name as currency_name',
                'country.name as country_name',
                'country_wise_bank.others_code',
                'country_wise_bank.status',
            )
            ->orderBy('country_wise_bank.id', 'desc') // Sorting in descending order
            ->get();

        return response()->json([
            'data' => $rows,
            'message' => 'success'
        ], 200);
    }



    public function getCountryCurrencyList(Request $request)
    {
        $rows = AddCountry::leftJoin('country', 'add_country.country_id', '=', 'country.id')
            ->leftJoin('currency', 'add_country.currency_id', '=', 'currency.id')
            ->select(
                'add_country.id',
                'add_country.currency_id',
                'add_country.country_id',
                'add_country.usdt_rate',
                'add_country.status',
                'country.name as country_name',
                'currency.name as currency_name',
                'currency.symbol as currency_symbol'
            )
            ->get();

        return response()->json([
            'data' => $rows,
            'message' => 'success'
        ], 200);
    }


    public function getCountryGroupList(Request $request)
    {
        $rows = CountryWiseBank::leftJoin('add_country', 'add_country.country_id', '=', 'country_wise_bank.country_id')
            ->leftJoin('country', 'add_country.country_id', '=', 'country.id')
            ->leftJoin('currency', 'add_country.currency_id', '=', 'currency.id')
            ->select(
                'country_wise_bank.id',
                'add_country.currency_id',
                'add_country.country_id',
                'add_country.usdt_rate',
                'country_wise_bank.bank_name',
                'country_wise_bank.account_name',
                'country_wise_bank.account_number',
                'country_wise_bank.ific_code',
                'currency.symbol as currency_symbol',
                'country_wise_bank.swift_code',
                'currency.name as currency_name',
                'country.name as country_name',
                'country_wise_bank.others_code',
                'country_wise_bank.status'
            )
            ->orderBy('country_wise_bank.id', 'desc') // Sort in descending order
            ->groupBy('add_country.country_id') // Group by country_id
            ->get();


        return response()->json([
            'data' => $rows,
            'message' => 'success'
        ], 200);
    }



    public function getCountryWiseBankRow(Request $request)
    {
        $id = (int) $request->id;
        $data = CountryWiseBank::where('id', $id)->first();
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }

    public function getCountryRow(Request $request)
    {
        $id = (int) $request->id;
        $data = AddCountry::where('id', $id)->first();
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }

    public function settingrow()
    {

        $data = Setting::find(1);
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }
    public function countryWiseShowBank()
    {
        $countrys =  AddCountry::where('add_country.status', 1)
            ->leftJoin('country', 'add_country.country_id', '=', 'country.id')
            ->leftJoin('currency', 'add_country.currency_id', '=', 'currency.id')
            ->select(
                'add_country.id',
                'add_country.currency_id',
                'add_country.country_id',
                'country.name as country_name',
                'currency.name as currency_name',
                'currency.symbol as currency_symbol'
            )
            ->get();

        $data = $countrys;
        $response = [
            'data' => $data,
            'message' => 'success'
        ];
        return response()->json($response, 200);
    }

    public function upateSetting(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name'        => 'required',
            'email'       => 'required',
            'currency'    => 'required',

            'register_bonus'    => 'required',
            'maximum_supply'    => 'required',
            'total_supply'      => 'required',

            'level_1_bonus'      => 'required',
            'level_2_bonus'      => 'required',
            'level_3_bonus'      => 'required',

            'liquidity_total_supply'      => 'required',
            'circlation'                  => 'required',
            'beganing_price'              => 'required',

        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $data = array(
            'name'              => !empty($request->name) ? $request->name : "",
            'email'             => !empty($request->email) ? $request->email : "",
            'address'           => !empty($request->address) ? $request->address : "",
            'whatsApp'          => !empty($request->whatsApp) ? $request->whatsApp : "",
            'description'       => !empty($request->description) ? $request->description : "",
            'copyright'         => !empty($request->copyright) ? $request->copyright : "",
            'currency'          => !empty($request->currency) ? $request->currency : "",
            'fblink'            => !empty($request->fblink) ? $request->fblink : "",
            'website'           => !empty($request->website) ? $request->website : "",
            'telegram'          => !empty($request->telegram) ? $request->telegram : "",

            'level_1_bonus'          => !empty($request->level_1_bonus) ? $request->level_1_bonus : "",
            'level_2_bonus'          => !empty($request->level_2_bonus) ? $request->level_2_bonus : "",
            'level_3_bonus'          => !empty($request->level_3_bonus) ? $request->level_3_bonus : "",

            'deposit_service_charge'      => !empty($request->deposit_service_charge) ? $request->deposit_service_charge : "",
            'withdraw_service_charge'     => !empty($request->withdraw_service_charge) ? $request->withdraw_service_charge : "",
            'crypto_wallet_address'       => !empty($request->crypto_wallet_address) ? $request->crypto_wallet_address : "",
            'store_policy'                => !empty($request->store_policy) ? $request->store_policy : "",
            'register_bonus'              => !empty($request->register_bonus) ? $request->register_bonus : 0,
            'maximum_supply'              => !empty($request->maximum_supply) ? $request->maximum_supply : 0,
            'total_supply'                => !empty($request->total_supply) ? $request->total_supply : 0,

            'mininmum_deposit_amount'               => !empty($request->mininmum_deposit_amount) ? $request->mininmum_deposit_amount : 0,
            'maximum_deposit_amount'                => !empty($request->maximum_deposit_amount) ? $request->maximum_deposit_amount : 0,
            'minimum_withdrawal'                    => !empty($request->minimum_withdrawal) ? $request->minimum_withdrawal : 0,
            'maximum_withdrawal'                    => !empty($request->maximum_withdrawal) ? $request->maximum_withdrawal : 0,
            'daily_max_withdraw_request'            => !empty($request->daily_max_withdraw_request) ? $request->daily_max_withdraw_request : 0,
            'withdrawal_free_amount'                => !empty($request->withdrawal_free_amount) ? $request->withdrawal_free_amount : 0,
            'withdrawal_free_on_percentage'         => !empty($request->withdrawal_free_on_percentage) ? $request->withdrawal_free_on_percentage : 0,
            'mimumun_transfer_amount_to_other_user' => !empty($request->mimumun_transfer_amount_to_other_user) ? $request->mimumun_transfer_amount_to_other_user : 0,
            'maximum_transfer_amount_to_other_user' => !empty($request->maximum_transfer_amount_to_other_user) ? $request->maximum_transfer_amount_to_other_user : 0,
            'transfer_fee_fixed_amount'             => !empty($request->transfer_fee_fixed_amount) ? $request->transfer_fee_fixed_amount : 0,
            'traansfer_fee_on_percentage'           => !empty($request->traansfer_fee_on_percentage) ? $request->traansfer_fee_on_percentage : 0,

            'liquidity_total_supply'                => !empty($request->liquidity_total_supply) ? $request->liquidity_total_supply : 0,
            //'circlation'                            => !empty($request->circlation) ? $request->circlation : 0,
            'beganing_price'                        => !empty($request->beganing_price) ? $request->beganing_price : 0,
        );

        //dd($data);
        DB::table('setting')->where('id', 1)->update($data);

        $response = [
            'message' => 'Successfull',
        ];
        return response()->json($response);
    }




    public function addCountryWiseBank(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make($request->all(), [
            'country_id'        => 'required',
            'bank_name'         => 'required',
            'account_name'      => 'required',
            'account_number'    => 'required',
            'status'            => 'required',
        ], [
            'country_id.required'       => 'The country is required.',
            'bank_name.required'        => 'The Bank Name is required.',
            'account_name.required'     => 'The Account Name is required.',
            'account_number.required'   => 'The Account Number is required.',
            'status.required'           => 'The status is required.',

        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $checkPointBank = AddCountry::where('country_id', $request->country_id)->first();

        $data = array(
            'add_country_id'    => $checkPointBank->id ?? "",
            'country_id'        => $request->country_id,
            'bank_name'         => $request->bank_name,
            'account_name'      => $request->account_name,
            'account_number'    => $request->account_number,
            'ific_code'         => !empty($request->ific_code) ? $request->ific_code : "",
            'swift_code'        => !empty($request->swift_code) ? $request->swift_code : "",
            'others_code'       => !empty($request->others_code) ? $request->others_code : "",
            'status'            => $request->status,
        );
        // dd($data);
        $id = !empty($request->id) ? $request->id : "";
        if (empty($id)) {
            $resdata['id']                   = CountryWiseBank::insertGetId($data);
        } else {
            $resdata['id']                   = CountryWiseBank::where('id', $id)->update($data);
        }
        return response()->json($resdata);
    }

    public function addCountryInfo(Request $request)
    {
        //dd($request->all());
        $validator = Validator::make($request->all(), [
            'country_id'  => 'required',
            'currency_id' => 'required',
            'usdt_rate'   => 'required',
            'status'      => 'required',
        ], [
            'country_id.required'  => 'The country is required.',
            'currency_id.required' => 'The currency is required.',
            'usdt_rate.required'   => 'The USDT rate is required.',
            'status.required'      => 'The status is required.',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }


        $data = array(
            'country_id'     => $request->country_id,
            'currency_id'    => $request->currency_id,
            'usdt_rate'      => $request->usdt_rate,
            'status'         => $request->status,
        );

        $id = !empty($request->id) ? $request->id : "";
        if (empty($id)) {
            $resdata['id']                   = AddCountry::insertGetId($data);
        } else {
            $resdata['id']                   = AddCountry::where('id', $id)->update($data);
        }
        return response()->json($resdata);
    }
}
