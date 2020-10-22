pragma solidity ^0.7.0;
//"SPDX-License-Identifier: CC0 1.0 " 
 
interface IExchange { 
    //获取兑换价格
    function Price(address token1,address token2,uint256 amount) external returns(uint256); 
    //进行实际的交易
    function Swap(address sender,address token1,address token2,uint256 amount) external returns(uint256);
    //添加流动性接口
    function AddLiquidity(address token1,uint256 amount1, address token2,uint256 amount2) external returns(bool);
    //移除流动性接口
    function RemoveLiquidity(address token1,uint256 amount1, address token2,uint256 amount2) external returns(bool);
}
