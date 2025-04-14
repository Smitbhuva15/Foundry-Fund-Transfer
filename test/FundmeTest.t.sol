// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {FundMe} from "../src/Fundme.sol";
import {Test} from "forge-std/Test.sol";
import {DeployFundme} from "../script/DeployFundme.s.sol";

contract FundmeTest is Test {
    FundMe fundme;

    uint256 public constant SEND_VALUE = 0.1 ether;
    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    address USER = makeAddr("user");

    function setUp() public {
        DeployFundme d1 = new DeployFundme();
        fundme = d1.run();
        vm.deal(USER, STARTING_USER_BALANCE);
    }

    function testMinimumUsdIsFive() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testcheckversion() public view {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert();
        fundme.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();

        uint256 amount = fundme.getAddressToAmountFunded(USER);
        assertEq(amount, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();

        address funderAddress = fundme.getFunder(0);
        assertEq(funderAddress, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.expectRevert();
        vm.prank(USER);
        fundme.withdraw();
    }

    function testWithdrawSingleOwner() public funded {
        uint256 ownerStartingBalance = fundme.getOwner().balance;
        uint256 fundmeStartingBalance = address(fundme).balance;

        vm.prank(fundme.getOwner());
        fundme.withdraw();

        uint256 ownerEndingBalance = fundme.getOwner().balance;
        uint256 fundmeEndingBalance = address(fundme).balance;

        assertEq(fundmeEndingBalance, 0);
        assertEq(
            ownerStartingBalance + fundmeStartingBalance,
            ownerEndingBalance
        );
    }

    function testWithdrawFromMultipleFunders() public funded {
        uint160 numberOfFunders = 10;
        for (uint160 i = 1; i < numberOfFunders; i++) {
            hoax(address(i), SEND_VALUE);
            fundme.fund{value: SEND_VALUE}();
        }

        uint256 ownerStartingBalance = fundme.getOwner().balance;
        uint256 fundmeStartingBalance = address(fundme).balance;

        vm.prank(fundme.getOwner());
        fundme.withdraw();
         uint256 ownerEndingBalance = fundme.getOwner().balance;
        uint256 fundmeEndingBalance = address(fundme).balance;

        assertEq(fundmeEndingBalance, 0);
        assertEq(
            ownerStartingBalance + fundmeStartingBalance,
            ownerEndingBalance
        );

    }
}
