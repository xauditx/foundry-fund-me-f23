// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() public returns (FundMe) {
        FundMe fundMe;
        HelperConfig helperConfig = new HelperConfig();
        address ethUSDPriceFeed = helperConfig.activeNetworkConfig();
        vm.startBroadcast();
        fundMe = new FundMe(ethUSDPriceFeed);
        vm.stopBroadcast;
        return fundMe;
    }
}
