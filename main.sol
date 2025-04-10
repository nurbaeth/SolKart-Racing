// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SolKartRacing {
    uint256 public raceId;
    uint256 public maxPlayers = 5;

    struct Player {
        address addr;
        string kart;
        uint256 speed; // randomly assigned
    }

    struct Race {
        uint256 id;
        Player[] players;
        address winner;
        bool started;
        bool finished;
    }

    mapping(uint256 => Race) public races;
    mapping(address => uint256) public wins;

    modifier notStarted(uint256 _raceId) {
        require(!races[_raceId].started, "Race already started");
        _;
    }

    modifier onlyBeforeStart() {
        require(!races[raceId].started, "Race already started");
        _;
    }

    event PlayerJoined(address indexed player, string kart, uint256 raceId);
    event RaceStarted(uint256 raceId);
    event RaceFinished(uint256 raceId, address winner);

    constructor() {
        raceId = 1;
    }

    function joinRace(string memory _kart) external onlyBeforeStart {
        Race storage race = races[raceId];
        require(race.players.length < maxPlayers, "Race full");

        for (uint256 i = 0; i < race.players.length; i++) {
            require(race.players[i].addr != msg.sender, "Already joined");
        }

        race.players.push(Player({
            addr: msg.sender,
            kart: _kart,
            speed: 0
        }));

        emit PlayerJoined(msg.sender, _kart, raceId);

        // Auto-start race when full
        if (race.players.length == maxPlayers) {
            startRace();
        }
    }

    function startRace() internal notStarted(raceId) {
        Race storage race = races[raceId];
        race.started = true;

        uint256 winningSpeed = 0;
        address winner;

        for (uint256 i = 0; i < race.players.length; i++) {
            // Pseudo-random number (not secure, but okay for demo)
            uint256 speed = uint256(
                keccak256(abi.encodePacked(block.timestamp, msg.sender, i))
            ) % 100;

            race.players[i].speed = speed;

            if (speed > winningSpeed) {
                winningSpeed = speed;
                winner = race.players[i].addr;
            }
        }

        race.winner = winner;
        race.finished = true;
        wins[winner]++;
        
        emit RaceStarted(raceId);
        emit RaceFinished(raceId, winner);

        // Start new race
        raceId++;
    }

    function getPlayers(uint256 _raceId) external view returns (Player[] memory) {
        return races[_raceId].players;
    }

    function getLeaderboard(address _player) external view returns (uint256) {
        return wins[_player];
    }
}
