// SPDX-License_Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlydeployed) public {
        FundMe(payable(mostRecentlydeployed)).fund{value: SEND_VALUE}();
        console.log("Contract has been funder with Amount", SEND_VALUE);
    }

    function run() external {
        address mostRecentlydeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        fundFundMe(mostRecentlydeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function withdrawFundMe(address mostRecentlydeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlydeployed)).withdraw();
        vm.stopBroadcast();
        console.log("Contract funds have been withdrawn", SEND_VALUE);
    }

    function run() external {
        address mostRecentlydeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast();
        withdrawFundMe(mostRecentlydeployed);
        vm.stopBroadcast();
    }
}
