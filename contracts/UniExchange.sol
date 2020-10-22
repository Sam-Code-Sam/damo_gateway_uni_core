pragma solidity ^0.7.0;
//"SPDX-License-Identifier: CC0 1.0 " 

import "./SafeExchange.sol";
import "./IExchange.sol";
import "./IUniswapV2Router01.sol";



contract UniExchange is SafeExchange,IExchange { 
    IUniswapV2Router01 public m_uni_router;
    constructor(address unirouter){
            m_uni_router = IUniswapV2Router01(unirouter);

    }

    public setUniRouter(address router) onlyOwner public{
        m_uni_router = IUniswapV2Router01(unirouter);
    }

    //获取兑换价格
    //    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function price(address tokenIn,address tokenOut,uint256 amountIn) external returns(uint256){
       address[] memory path = new address[2];
       path[0] = tokenIn;
       path[1] = tokenOut;
       uint[] memory amounts = m_uni_router.getAmountsOut(amountIn,path);
       return amounts[1];
    }
    //进行实际的交易
    /**
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
        ) external returns (uint[] memory amounts);
     */ 
    function swap(address tokenIn,address tokenOut,uint256 amountIn,uint256 amountOutMin,address to,uint256 deadline) external returns(uint256){
       address[] memory path = new address[2];
       path[0] = token1;
       path[1] = tokenOut;


       uint[] memory amounts = m_uni_router.swapExactTokensForTokens(amountIn,amountOutMin,path,to,deadline);
       return amounts[1];

    }
 
    /**添加流动性接口
      function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) returns (uint amountA, uint amountB, uint liquidity) 
     */
     function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external ensure(deadline) returns (uint amountA, uint amountB, uint liquidity) {
       return m_uni_router.addLiquidity(tokenA,tokenB,amountADesired,amountBDesired,amountAMin,amountBMin,to,deadline);
    }

    /**移除流动性接口
        function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) public virtual override ensure(deadline) returns (uint amountA, uint amountB) 
    */
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) public virtual  ensure(deadline) returns (uint amountA, uint amountB) {
        return m_uni_router.removeLiquidity(tokenA,tokenB,liquidity,amountAMin,amountBMin,to,deadline);
    }
}
