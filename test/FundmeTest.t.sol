// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {FundMe} from "../src/Fundme.sol";
import {Test} from "forge-std/Test.sol";
import {DeployFundme} from '../script/DeployFundme.s.sol';

contract FundmeTest is Test {
    FundMe fundme;

    function setUp() public {
        DeployFundme d1 = new DeployFundme();
        fundme = d1.run();
    }
 function testMinimumUsdIsFive() public  view{
        assertEq(fundme.MINIMUM_USD(), 5e18); 
    }
    
}
