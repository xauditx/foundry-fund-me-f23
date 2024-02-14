// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10e18;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimumDollarisFive() public {
        console.log("Alhamdulillah, FundMe is deployed correctly");
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testIfOwnerEqualsMsgSender() public {
        console.log("Checking if msg.sender is equal to owner");
        console.log(fundMe.i_owner());
        console.log(address(this));
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testIfPriceVersionisFour() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund{value: 1}();
    }

    /* function testAllAspectsOfFundFunction() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        uint256 finalAmountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(finalAmountFunded, SEND_VALUE);
    } */
}
