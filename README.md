# bcu23d-solidity-voting-system

Final assignment for Smart Contract course in BCU23D. It is a voting system for favorite song.

In this assignment, you will have the opportunity to use the concepts and tools that we have gone through. Choose one of the three themes below and then develop a smart contract in Solidity:

Develop a contract where users can vote for their favorite movie from a list. Voting must be open for a certain period of time, after which the votes will be counted to determine a winner. The contract must have functions to create a poll, start the poll, cast a vote, and count the votes. When a vote is finished, the winning film will be presented. Each poll must be linked to the user who created it.
Develop a contract to manage registrations for an event. Users can register by paying a fee, and the registration will be closed when a certain limit is reached, or a deadline has passed. The contract must include functions for registering a new event, opening and closing registration, registration for the event, handling payment, as well as a list of all registered participants per event.
Develop a contract that acts as a simple digital notepad, where users can add and store short notes. In addition to this, users should be able to share their notes with specific users, or make them public for everyone to read. The contract must have functions to create, read, adjust the sharing setting and delete notes. Each note must be linked to the user who created it.

Basic requirements ("Passed"):
The contract must contain the following elements:

√ At least one struct or enum
√ At least one mapping or array

- A constructor
  √ At least one custom modifier
- At least one event to log important events
- In addition to the above requirements, you must also write tests for the contract that cover basic functionality. Ensures that all important functions work as expected, and that you have a test coverage of at least 40%.

To reach "Passed with distiction", you must meet all requirements for "Passed" level, as well as:

- The contract must contain at least one custom error, as well as at least one require, one assert, and one revert
- The contract must contain a fallback and/or receive function
- Deploy your smart contract on the Ethereum network and verify the contract on Etherscan. Link to the verified contract page in your submission.
- Ensure that your contract has a test coverage of at least 90%.
- Identify and implement at least three gas optimizations and/or security measures in your contract (using the latest version of solidity or optimizer does not count!). Explain what actions you have taken, why they are important, and how they improve gas usage and/or contract security.
