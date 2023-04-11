// This is a feature called change vote which I coded for Agora project. It has three part 1. general 2.Preference 3.Score
//These 3 are the 3 algorithm agora used for it's voting.
//1. general
mapping(bytes32=>uint)vote_casted;
function changeVote(bytes32 _voter, uint _new_candidate, uint _weight) external override{
    _weight=1;
    uint prev_candidate=vote_casted[_voter];
    votes[prev_candidate]-=1;
    votes[_new_candidate]+=1;
    vote_casted[_voter]=_new_candidate;// the new result is stored in the data base
}
//2. Preference
mapping(bytes32=>uint [])vote_casted;//in the array the preference and candidate id is getting stored respectively.
// which means index 0,2,4.. will store preference and index 1,3,5...will store candidate id.
function changeVote(bytes32 _voter, uint _new_candidate, uint _preference) external override{
    // The candidate in that preference first need to be found out
    uint prev_candidate;//candidate that was previously in that preference
    uint prev_preference;//previous preference of the _new_candidate
    uint i; 
    uint j;
    for( i=0;i<candidates.length*2;i=i+2) // finding the candidate who was previously in the _preference
    {   
        if(vote_casted[_voter][i]==_preference)
        prev_candidate=vote_casted[_voter][i+1];

    }
    for( j=1;j<candidates.length*2;j=j+2) // finding the preference of the _new_candidate
    {   
        if(vote_casted[_voter][j]==_new_candidate)
       prev_preference=vote_casted[_voter][j-1];

    }
    // votes got switched in the main db
    votes[prev_preference][_new_candidate]-=1;// one vote get deducted from the previous preference of _new_candidate
    votes[_preference][_new_candidate]+=1;// one vote increased in the new preference of _new_candidate
    votes[_preference][prev_candidate]-=1;// one vote get deducted of prev_candidate from new preference
    votes[prev_preference][prev_candidate]+=1;// one vote increased in the previous preference of prev_candidate
    //votes get switced in the personal db
    vote_casted[_voter][i+1]=_new_candidate;
    vote_casted[_voter][j]=prev_candidate;
}

//3. Score
mapping(bytes32=>uint [])vote_casted;//in the array the scores and candidate id is getting stored respectively.
// which means index 0,2,4.. will store scores and index 1,3,5...will store candidate id.
function changeVote(bytes32 _voter, uint _candidate, uint _new_score) external override{
   
    uint prev_score;//previous score of that candidate will get stored 
    uint i; 
   
    for( i=1;i<candidates.length*2;i=i+2) // finding the previous score of that candidate
    {   
        if(vote_casted[_voter][i]==_candidate)
       prev_score=vote_casted[_voter][j-1];

    }
   // score gets adjusted in the main db
    scores[_candidate]=scores[_candidate]-prev_score;// deducts the previous amount of score from main db
    scores[_candidate]=scores[_candidate]+_new_score;// adds new score to the main db

    //score gets adjusted in vote_casted db
    vote_casted[_voter][i-1]=_new_candidate;
}


   function vote(bytes32 _voter, uint _candidate, uint _preference) external override{
       //previous codes
       vote_casted[_voter].push(_score);
       vote_casted[_voter].push(_candidate);
    }
      function vote(bytes32 _voter, uint _candidate, uint _weight)external override{
           //previous codes
           vote_casted[_voter].push(_candidate);

    }  
     hash = keccak256(abi.encodePacked(name,wallet_address,unique_id,password));
