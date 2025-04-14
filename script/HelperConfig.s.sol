// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from 'forge-std/Script.sol';
import {MockV3Aggregator} from '../test/mock/MockV3Aggregator.sol';

contract HelperConfig is Script{

      struct NetworkConfig {
        address priceFeed;
    }

    NetworkConfig public activeNetworkConfig;

    constructor (){
        if(block.chainid==11155111){
          activeNetworkConfig=getSepoliaEthConfig();
        }
        else{
         activeNetworkConfig=getOrCreateAnvilEthConfig();
        }

    }

    function getSepoliaEthConfig() public pure returns(NetworkConfig memory){
        return NetworkConfig({
            priceFeed:0x694AA1769357215DE4FAC081bf1f309aDC325306 
        });
    }



        // //////////////   LOCAL CONFIG   /////////////


    function getOrCreateAnvilEthConfig() public returns(NetworkConfig memory) {
    vm.startBroadcast();
    MockV3Aggregator mockPriceFeed = new MockV3Aggregator(8, 2000e8);
    vm.stopBroadcast();

    return NetworkConfig({
        priceFeed: address(mockPriceFeed)
    });
}

}