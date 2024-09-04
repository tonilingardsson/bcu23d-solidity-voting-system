// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract VotingSystem {
    // Define the structures, variables, and mappings here

    enum PollStatus {
        NotStarted,
        Ongoing,
        Ended
    }
    struct Poll {
        address creator;
        string[] songList;
        uint startTime;
        uint endTime;
        mapping(string => uint) votes;
        bool isPollActive;
        bool isPollEnded;
    }

    uint public pollCount = 0;
    mapping(uint => Poll) public polls;
    mapping(address => mapping(uint => bool)) public hasVoted;

    // Constructor
    constructor(string[] memory _songList, uint _votingDuration) {
        for (uint i = 0; i < _songList.length; i++) {
            string memory song = _songList[i];
            polls[pollCount].songList.push(song);
            polls[pollCount].votes[song] = 0;
        }
        // Initialize state variables if needed
    }

    // Define functions to create poll, start poll, cast vote, count votes, and get winner here
    function createPoll(
        string[] memory _songList,
        uint _votingDuration
    ) public {
        pollCount++;
        Poll storage newPoll = polls[pollCount];
        newPoll.creator = msg.sender;
        newPoll.songList = _songList;
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

    function castVote(uint _pollId, string memory _songName) public {
        require(polls[_pollId].isPollActive, "Poll is not active");
        require(
            block.timestamp <= polls[_pollId].endTime,
            "Voting period has ended"
        );
        require(!hasVoted[msg.sender][_pollId], "You have already voted");

        emit VoteCast(_pollId, msg.sender, _songName);
    }

    function countVotes(uint _pollId) public onlyCreator(_pollId) {
        require(polls[_pollId].isPollActive, "Poll is not active");
        require(
            block.timestamp > polls[_pollId].endTime,
            "Voting is still going on"
        );
        polls[_pollId].isPollActive = false;
        polls[_pollId].isPollEnded = true;

        string memory winningSong;
        uint winningVoteCount = 0;

        Poll storage poll = polls[_pollId];
        for (uint i = 0; i < poll.songList.length; i++) {
            string memory song = poll.songList[i];
            uint voteCount = poll.votes[song];
            if (voteCount > winningVoteCount) {
                winningVoteCount = voteCount;
                winningSong = song;
            }
        }

        emit PollEnded(_pollId, winningSong);
    }

    function getWinner(uint _pollId) public view returns (string memory) {
        require(polls[_pollId].isPollEnded, "Poll is not ended yet");
        string memory winningSong;
        uint winningVoteCount = 0;

        Poll storage poll = polls[_pollId];
        for (uint i = 0; i < poll.songList.length; i++) {
            string memory song = poll.songList[i];
            uint voteCount = poll.votes[song];
            if (voteCount > winningVoteCount) {
                winningVoteCount = voteCount;
                winningSong = song;
            }
        }
        return winningSong;
    }
}
