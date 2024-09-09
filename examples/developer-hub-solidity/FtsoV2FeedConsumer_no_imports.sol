// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IFlareContractRegistry {
    function getContractAddressByName(
        string calldata _name
    ) external view returns (address);
}

interface FtsoV2Interface {
    function getFeedsById(
        bytes21[] calldata _feedIds
    )
        external
        payable
        returns (
            uint256[] memory _values,
            int8[] memory _decimals,
            uint64 _timestamp
        );
}

/**
 * THIS IS AN EXAMPLE CONTRACT.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */
contract FtsoV2FeedConsumer {
    IFlareContractRegistry internal contractRegistry;
    FtsoV2Interface internal ftsoV2;

    // Feed IDs, see https://dev.flare.network/ftso/feeds for full list
    bytes21[] public feedIds = [
        bytes21(0x01464c522f55534400000000000000000000000000), // FLR/USD
        bytes21(0x014254432f55534400000000000000000000000000), // BTC/USD
        bytes21(0x014554482f55534400000000000000000000000000) // ETH/USD
    ];

    /**
     * Constructor initializes the contract registry and fetches the FTSOv2 contract address.
     */
    constructor() {
        contractRegistry = IFlareContractRegistry(
            0xaD67FE66660Fb8dFE9d6b1b4240d8650e30F6019
        );
        ftsoV2 = FtsoV2Interface(
            contractRegistry.getContractAddressByName("FtsoV2")
        );
    }

    /**
     * Get the current value of the feeds.
     */
    function getFtsoV2CurrentFeedValues()
        external
        payable
        returns (
            uint256[] memory _feedValues,
            int8[] memory _decimals,
            uint64 _timestamp
        )
    {
        (
            uint256[] memory feedValues,
            int8[] memory decimals,
            uint64 timestamp
        ) = ftsoV2.getFeedsById(feedIds);
        /* Your custom feed consumption logic. */
        /* In this example the feed values, decimals and last updated timestamp are just returned. */
        return (feedValues, decimals, timestamp);
    }
}
