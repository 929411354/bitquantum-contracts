// SPDX-License-Identifier: UNLICENSED
// Copyright (c) 2025 BitQuantum
// GitHub: https://github.com/bitquantum/dependencies/blob/main/contracts/interop/BitQuantumInterop.sol

pragma solidity ^0.8.25;

abstract contract BitQuantumInterop {
    // 事件
    event ContractCall(address indexed caller, address indexed target, bytes data, bytes result);
    
    // 安全调用外部合约
    function _safeCall(
        address target,
        bytes calldata data
    ) internal returns (bytes memory) {
        require(target != address(this), "Cannot call self");
        
        (bool success, bytes memory result) = target.call(data);
        require(success, "External call failed");
        
        emit ContractCall(msg.sender, target, data, result);
        return result;
    }
    
    // 统一调用入口
    function _universalCall(
        bytes calldata data
    ) internal returns (bytes memory) {
        // 获取函数选择器
        bytes4 selector;
        assembly {
            selector := calldataload(data.offset)
        }
        
        // 委托调用当前实现
        // 在实际项目中，这里会调用升级系统的实现
        (bool success, bytes memory result) = address(this).delegatecall(data);
        require(success, "Universal call failed");
        return result;
    }
}
