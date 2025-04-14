// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/Fundme.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundme is Script {
    
    function run() external returns (FundMe) {
        HelperConfig helperConfig =new HelperConfig();
        address priceFeedAddress =helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundme = new FundMe(priceFeedAddress);
        vm.stopBroadcast();

        return fundme;
    }
}






