// SPDX-License-Identifier: UNLICENSED
// Copyright (c) 2025 BitQuantum

pragma solidity ^0.8.25;

import "@openzeppelin/contracts/access/AccessControl.sol";

abstract contract BitQuantumAdmin is AccessControl {
    // 修复拼写错误，添加下划线
    bytes32 public constant UPGRADE_MANAGER_ROLE = keccak256("UPGRADE_MANAGER_ROLE");
    bytes32 public constant FREEZE_MANAGER_ROLE = keccak256("FREEZE_MANAGER_ROLE"); 
    bytes32 public constant MINT_MANAGER_ROLE = keccak256("MINT_MANAGER_ROLE");
    
    // DEFAULT_ADMIN_ROLE 已由 AccessControl 提供
    address public deployer;
    
    constructor() {
        deployer = msg.sender;
        
        // 使用正确的角色常量
        _grantRole(DEFAULT_ADMIN_ROLE, deployer);
        _grantRole(UPGRADE_MANAGER_ROLE, deployer);
        _grantRole(FREEZE_MANAGER_ROLE, deployer);
        _grantRole(MINT_MANAGER_ROLE, deployer);
    }
    
    function grantAdminRole(bytes32 role, address account) external onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(role, account);
    }
    
    function revokeAdminRole(bytes32 role, address account) external onlyRole(DEFAULT_ADMIN_ROLE) {
        revokeRole(role, account);
    }
}
