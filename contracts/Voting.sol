pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates;
    address owner;
    mapping(address=>bool) public voters;
    uint256 public votingStart;
    uint256 public votingEnd;
    
    // called once the contract is deployed
    // memory is a data loaction spcefier, it tells the Ethereum Virtual Machine where to stoer data
    constructor(string[] memory _candidateNames,uint256 _durationInMinutes){
        for(uint256 i = 0 ; i<_candidateNames.length;i++){
              candidates.push(Candidate({name:_candidateNames[i],voteCount:0}))  ;
        }
        owner= msg.sender;  // address of the owner of the contract
        votingStart = block.timestamp;
        votingEnd = block.timestamp + (_durationInMinutes * 1 minutes);
    }

// modifiers are used to check a certain condition before executing a function
modifier onlyOwner {
    require(msg.sender == owner); // the caller of the function is the owner of this contract
    _;  // placeholder for the function body to which the modifier is applied
}

    // only owner can add a candidate
    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate({
            name:   _name,
            voteCount:  0
        }));
    }

    function vote(uint256 _candidateIndex) public {
        // require is used to enforce conditions and validate inputs
        // msg.sender contains the address of the caller of the function vote within the contract
        require(!voters[msg.sender],"You have already voted.");     // if this  evaluates to false the transaction is reverted and the changes made to the state of the contract are undone
        require(_candidateIndex < candidates.length, "Invalid candidate index.");
        candidates[_candidateIndex].voteCount++;
        voters[msg.sender] = true ;
    }

    // view = doesnt modify the state of the contract, and can be called without sending a transaction ie no gas fees
    function getAllVotesOfCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getVotingStatus() public view returns (bool) {
        return (block.timestamp >= votingStart && block.timestamp  < votingEnd);
    }

    function getRemainingTime() public view returns (uint256) {
        require(block.timestamp >= votingStart, "Voting hasn't started yet");
        if(block.timestamp >= votingEnd) {
            return 0;
        }
        return votingEnd - block.timestamp ;
    }
}