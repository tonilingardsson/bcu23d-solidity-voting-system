// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract VotingSystem {
    // Define the structures, variables, and mappings here
    struct Poll {
        address creator;
        string[] recordList;
        uint startTime;
        uint endTime;
        mapping(string => uint) votes;
        bool isPollActive;
        bool isPollEnded;
    }

    uint public pollCount = 0;
    mapping(uint => Poll) public polls;
    mapping(address => mapping(uint => bool)) public hasVoted;

    enum PollStatus {
        NotStarted,
        Ongoing,
        Ended
    }

    // Constructor
    constructor() {
        // Initialize state variables if needed
    }

    // Define functions to create poll, start poll, cast vote, count votes, and get winner here
    function createPoll(
        string[] memory _recordList,
        uint _votingDuration
    ) public {
        pollCount++;
        Poll storage newPoll = polls[pollCount];
        newPoll.creator = msg.sender;
        newPoll.recordList = _recordList;
        newPoll.startTime = block.timestamp;
        newPoll.endTime = newPoll.startTime + _votingDuration;
        newPoll.isPollActive = true;
        newPoll.isPollEnded = false;

        emit PollCreated(pollCount, msg.sender);
    }

    modifier onlyCreator(uint _pollId) {
        require(
            msg.sender == polls[_pollId].creator,
            "Only the poll's creator can start this poll"
        );
        _;
    }

    function startPoll(uint _pollId) public onlyCreator(_pollId) {
        require(polls[_pollId].isPollActive, "Poll is not active");
        require(
            block.timestamp >= polls[_pollId].startTime,
            "Voting has nort started yet"
        );
        emit PollStarted(_pollId, block.timestamp);
    }
}
