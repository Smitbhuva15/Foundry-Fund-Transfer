// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from 'forge-std/Script.sol';

contract HelperConfig is Script{

      struct NetworkConfig {
        address priceFeed;
    }

    NetworkConfig activeNetworkConfig;

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

    function getOrCreateAnvilEthConfig() public pure {
       
    }
}