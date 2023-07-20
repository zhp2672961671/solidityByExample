// SPDX 版权许可标识
// SPDX-License-Identifier: MIT
//版本标识
pragma solidity ^0.8.17;
/*
https://eips.ethereum.org/EIPS/eip-721
ERC721同样是一个非同质代币标准
ERC721为一个合约标准，提供了在实现ERC721代币时必须要遵守的协议，
要求每个ERC721标准合约需要实现ERC721及ERC165接口
*/
interface IERC165 {
    //@notice查询合约是否实现接口
    //@param接口ID interfaceID 接口标识符，如ERC-165中所指定
    //@dev接口标识在ERC-165上指定。此功能
    //使用的气体少于30000。
    //如果合约实现了"interfaceID"，则返回"true"，并且
    //"interfaceID"不是0xffffffff，否则返回"false"
    function supportsInterface(bytes4 interfaceID) external view returns (bool) ;

}

interface IERC721 is IERC165 {
    // @notice 对分配给所有者的所有 NFT 进行计数 
    // @dev 分配给零地址的 NFT 被视为无效，并且此 
    // 函数会抛出有关零地址的查询。
    // @param _owner 查询余额的地址 
    // @return `_owner` 拥有的 NFT 数量，可能为零
    function balanceOf (address _owner) external view returns (uint256); 
    // @notice 查找 NFT 的所有者 
    // @dev NFT 分配给零地址被认为是无效的，并且 
    // 关于它们的查询确实会抛出。
    // @param token Id NFT 的标识符 
    // @return NFT 所有者的地址
    function ownerOf(uint256 _tokenId) external view returns (address);
    // @notice 将 NFT 的所有权从一个地址转移到另一个地址 
    // @dev 抛出异常，除非 `msg.sender` 是该 NFT 的当前所有者、授权操作者或批准的地址。
    //  如果 `_from` 不是当前所有者，则抛出异常。
    //  如果 `_to` 是零地址则抛出异常。 
    //  如果 `token Id` 不是有效的 NFT，则抛出异常。传输完成后，此函数 
    // 检查 `_to` 是否是智能合约（代码大小 > 0）。 如果是这样，它会在 `_to` 上调用 
    // `on ERC721 Received` 并在返回值不是 
    // `bytes4(keccak256("on ERC721 Received(address,address,uint256,bytes)"))` 时抛出异常 。
    // @param _from NFT 的当前所有者 
    // @param _to 新所有者 
    // @param token Id 要转移的 NFT
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable ;
    // @notice 将 NFT 的所有权从一个地址转移到另一个地址 
    // @dev 这与带有额外数据参数的其他函数的工作方式相同，
    // 除了该函数只是将数据设置为“”。
    // @param _from NFT 的当前所有者 
    // @param _to 新所有者 
    // @param token Id 要转移的 NFT
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable ;
    // @notice 转移 NFT 的所有权——调用者负责 
    // 确认 `_to` 能够接收 NFTS 否则 
    // 它们可能会永久丢失 
    // @dev 抛出异常，除非 `msg.sender` 是该 NFT 的当前所有者、授权 
    // 运营商或批准的地址。
    // 如果 `_from` 不是当前所有者，则抛出异常。
    // 如果 `_to` 是零地址则抛出异常。
    // 如果 `token Id` 不是有效的 NFT，则抛出异常。
    // @param _from NFT 的当前所有者 
    // @param _to 新所有者 
    // @param token Id 要转移的 NFT
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    //@notice更改或重申NFT的批准地址
    //@dev零地址表示没有批准的地址。
    //除非“msg.sesender”是当前NFT所有者或当前所有者的授权操作员，否则将抛出异常。
    //@param _approved新的已批准NFT控制器
    //@param token Id要批准的NFT
    function approve(address _approved, uint256 _tokenId) external  payable ;
    //@notice获取单个NFT的批准地址
    //@dev如果“token Id”不是有效的NFT则抛出异常。
    //@param token Id查找批准地址的NFT
    //@return此NFT的批准地址，如果没有，则为零地址
    function getApproved(uint256 _tokenId) external view returns (address);
    //@notice为第三方（“操作员”）启用或禁用审批以管理所有`msg.sender`的资产
    //@dev发出approval for all事件。合约必须允许每个所有者有多个操作员。
    //@param_operator要添加到授权操作员集中的地址
    //@param_approved如果操作员已批准则为True，如果操作员已获得批准则为false以撤销批准
    function setApprovalForAll(address _operator, bool _approved) external ;
    //@notice查询一个地址是否是另一个地址的授权运算符
    //@param_owner拥有NFT的地址
    //@pparam_operator代表所有者的地址
    //如果“_operator”是“_owner”的批准运算符，则返回True，否则返回false
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
    
}
//@dev注意：这个接口的ERC-165标识符是0x150b7a02。
interface ERC721TokenReceiver {
    //@notice处理NFT的接收
    //@dev ERC721智能合约在“转账”后
    //对接收者调用此函数。此函数可能会抛出以恢复和拒绝传输。
    //返回magic 以外的值必须导致事务被还原。
    //注意：合约地址始终是邮件发件人。
    //@param_operator调用“安全传输自”函数的地址
    //@param_From以前拥有令牌的地址
    //@@param令牌Id正在传输的NFT标识符
    //@pparam _data没有指定格式的其他数据
    //@return `bytes4（keccak256（“on ERC721 Received（address，address，uint256，bytes）”）
    function onERC721Received(address _operator, address _from, uint256 _tokenId,  bytes calldata _data) external returns(bytes4);
}

contract  ERC721 is IERC721 {
    //@dev当任何NFT的所有权通过任何机制更改时发出。
    //当NFT被创建（`from`==0）和销毁（`to`==0。例外情况：在合约创建过程中，可以创建和分配任何数量的NFT而不会发出转让。
    // 在进行任何转让时，该NFT的批准地址（如有）将重置为无。
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    //@dev当NFT的批准地址被更改或重申时，它会发出。零地址表示没有批准的地址。
    //当传输事件发出时，这也表示该NFT的批准地址（如果有）重置为无。
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    //@dev在为所有者启用或禁用运算符时发出。
    //运营商可以管理所有者的所有NFT。
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    // Mapping from token ID to owner address
    mapping(uint => address) internal _ownerOf;

    // Mapping owner address to token count
    mapping(address => uint) internal _balanceOf;

    // Mapping from token ID to approved address
    mapping(uint => address) internal _approvals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) public isApprovedForAll;
    // 是否使用了 ERC721接口
    function supportsInterface(bytes4 interfaceId) external pure returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }
    // 获取代币拥有地址
    function ownerOf(uint id) external view returns (address owner) {
        owner = _ownerOf[id];
        require(owner != address(0), "token doesn't exist");
    }
    // 获取owner地址代币数量
    function balanceOf(address owner) external view returns (uint) {
        require(owner != address(0), "owner = zero address");
        return _balanceOf[owner];
    }
    // 设置 给operator的授权情况
    function setApprovalForAll(address operator, bool approved) external {
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }
    function approve(address spender, uint id) external payable {
        address owner = _ownerOf[id];
        require(
            msg.sender == owner || isApprovedForAll[owner][msg.sender],
            "not authorized"
        );

        _approvals[id] = spender;

        emit Approval(owner, spender, id);
    }
    // 获取token的approve地址
    function getApproved(uint id) external view returns (address) {
        require(_ownerOf[id] != address(0), "token doesn't exist");
        return _approvals[id];
    }
    // 判断是否是token的拥有者或者被授权approve
    function _isApprovedOrOwner(
        address owner,
        address spender,
        uint id
    ) internal view returns (bool) {
        return (spender == owner ||
            isApprovedForAll[owner][spender] ||
            spender == _approvals[id]);
    }

    function transferFrom(address from, address to, uint id) public payable {
        require(from == _ownerOf[id], "from != owner");
        require(to != address(0), "transfer to zero address");

        require(_isApprovedOrOwner(from, msg.sender, id), "not authorized");

        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[id] = to;

        delete _approvals[id];

        emit Transfer(from, to, id);
    }

    function safeTransferFrom(address from, address to, uint id) external payable {
        transferFrom(from, to, id);

        require(
            to.code.length == 0 ||
                ERC721TokenReceiver(to).onERC721Received(msg.sender, from, id, "") ==
                ERC721TokenReceiver.onERC721Received.selector,
            "unsafe recipient"
        );
    }

    function safeTransferFrom(
        address from,
        address to,
        uint id,
        bytes calldata data
    ) external payable {
        transferFrom(from, to, id);

        require(
            to.code.length == 0 ||
                ERC721TokenReceiver(to).onERC721Received(msg.sender, from, id, data) ==
                ERC721TokenReceiver.onERC721Received.selector,
            "unsafe recipient"
        );
    }
    // 铸造token
    function _mint(address to, uint id) internal {
        require(to != address(0), "mint to zero address");
        require(_ownerOf[id] == address(0), "already minted");

        _balanceOf[to]++;
        _ownerOf[id] = to;

        emit Transfer(address(0), to, id);
    }
    // 销毁token
    function _burn(uint id) internal {
        address owner = _ownerOf[id];
        require(owner != address(0), "not minted");

        _balanceOf[owner] -= 1;

        delete _ownerOf[id];
        delete _approvals[id];

        emit Transfer(owner, address(0), id);
    }
}
contract MyNFT is ERC721 {
    function mint(address to, uint id) external {
        _mint(to, id);
    }

    function burn(uint id) external {
        require(msg.sender == _ownerOf[id], "not owner");
        _burn(id);
    }
}

