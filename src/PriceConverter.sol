// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
    
    function getPrice(AggregatorV3Interface   s_address) internal view returns (uint256) {
    
        AggregatorV3Interface priceFeed = AggregatorV3Interface(s_address);
        (, int256 answer, , , ) = priceFeed.latestRoundData();
      
        return uint256(answer * 10000000000);
    }

  
    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface  s_address
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(s_address);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        
        return ethAmountInUsd;
    }
}