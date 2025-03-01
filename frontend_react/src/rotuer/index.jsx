// src/Router.js
import React, { Fragment } from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";

//Frontend
import Index from "../pages/Index.jsx";
import Market from "../pages/Market.jsx";
import Deposit from "../pages/dashboard/Deposit.jsx";
import Future from "../pages/Future.jsx";
import Withdraw from "../pages/dashboard/Withdraw.jsx";
import Profile from "../pages/dashboard/Profile.jsx";
import Wallet from "../pages/dashboard/Wallet.jsx";
import Payment from "../pages/dashboard/Payment.jsx";
import TradeHistory from "../pages/dashboard/TradeHistory.jsx";
import Kyc from "../pages/dashboard/KYC.jsx";
import Futuretrading from "../pages/Futuretrading.jsx";
import Login from "../pages/Login";
import LoginTrade from "../pages/LoginTrade";
import Register from "../pages/Register.jsx";
import DepositCrypto from "../pages/dashboard/DepositCrypto.jsx";
import DepositBank from "../pages/dashboard/DepositBank.jsx";
import ChangePassword from "../pages/dashboard/ChangePassword.jsx";
import MobileMenu from "../pages/dashboard/MobileMenu.jsx";


//<Route path="/dashboard" element={<ProtectedRoute><Dashboard /></ProtectedRoute>}/>
const AppRouter = () => {
  return (
    <Routes>
      <Route path="/" element={<Index />} />
      <Route path="/market" element={<Market />} />
      <Route path="/dashboard/deposit" element={<Deposit />} />
      <Route path="/withdraw" element={<Withdraw />} />
      <Route path="/future/:slug" element={<Future />} />
      <Route path="/dashboard/withdraw" element={<Withdraw />} />
      <Route path="/dashboard/profile" element={<Profile />} />
      <Route path="/dashboard/wallet" element={<Wallet />} />

      <Route path="/dashboard/payment" element={<Payment />} />
      <Route path="/dashboard/trade-history" element={<TradeHistory />} />
      <Route path="/dashboard/kyc" element={<Kyc />} />
      <Route path="/login" element={<Login />} />
      <Route path="/login-trade" element={<LoginTrade />} />
      <Route path="/future-trading" element={<Futuretrading />} />
      <Route path="/register" element={<Register />} />
      <Route path="/deposit-crypto/:slug" element={<DepositCrypto />} />
      <Route path="/deposit-bank/:bankId/:countryId" element={<DepositBank />} />
      <Route path="/change-password" element={<ChangePassword />} />
      <Route path="/dashboard/mobile-menu" element={<MobileMenu />} />

      {/* <Route path="/hoster-profile:slug" element={<HosterProfile />} />
      <Route path="/adult-categorys/:slug" element={<Adultcategory />} />
      <Route path="/hoster-details/:slug" element={<HosterDetails />} />
      <Route path="/watch-videos/:slug" element={<WatchVideos />} />
      <Route path="/games-list/:slug" element={<Games />} />
      <Route path="/model-list" element={<ModelList />} />
      <Route path="/affiliate" element={<Affiliate />} />
      <Route path="/all-games" element={<AllGames />} />
  
      <Route path="/games-zone/:slug" element={<GameZone />} />
      <Route path="/market" element={<Market />} />
      <Route path="/invide-code/:slug" element={<InviteCode />} />

      <Route path="/my-profile" element={<MyProfile />} />
      <Route path="/refer" element={<Refer />} />
      <Route path="/personal-information" element={<PersonalInformation />} />
      <Route path="/about" element={<About />} />
      <Route path="/faq" element={<Faq />} />
      <Route path="/transection" element={<Transection />} />

 
      <Route path="/login" element={<Login />} />
      <Route path="/user-login" element={<UserLogin />} />
      <Route path="/bet-history" element={<BetHistory />} />
      <Route path="/hoster-list" element={<HosterList />} />
      <Route path="/videos" element={<Videos />} />
      <Route path="/signup" element={<Signup />} />
      <Route path="/forget-password" element={<Forgetpassword />} />

      <Route path="/deposit-amount" element={<DepositAmount />} />
      <Route path="/deposit-history" element={<DepositHistory />} />
      <Route path="/withdrawal-history" element={<WithdrawalHistory />} />
      <Route path="/wallet" element={<Wallet />} />
      <Route path="/terms-and-conditions" element={<TermsAndConditions />} />
      <Route path="/privacy-policy" element={<PrivacyPolicy />} />
      <Route path="/game-list" element={<GameList />} />
      <Route path="/all-platform-list" element={<AllGameList />} />
      <Route path="/platform-games/:slug" element={<PlatformGames />} />
      <Route path="/play-videos/:slug" element={<PlayVideos />} />
      <Route path="/star-list" element={<StarList />} />
      <Route path="/video-gallery" element={<VideoGallery />} />

      <Route path="/hoster-profile" element={<HosterProfile />} />
      <Route path="/user/profile" element={<UserProfile />} />
      <Route path="/user/change-password" element={<ChangePassword />} />
      <Route path="/dashboard" element={<Dashboard />} /> */}
    </Routes>
  );
};

export default AppRouter;
