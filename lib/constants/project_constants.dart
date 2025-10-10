enum ProjectConstants {
  valorantIntel(
    repo: "https://github.com/amiralitaherkhany/valorant-intel",
    name: "Valorant Intel",
    screenShots: [
      "${_baseUrl}valorant-intel/master/screenshots/Screenshot_20250611-212130.jpg",
      "${_baseUrl}valorant-intel/master/screenshots/Screenshot_20250611-212140.jpg",
      "${_baseUrl}valorant-intel/master/screenshots/Screenshot_20250611-212149.jpg",
      "${_baseUrl}valorant-intel/master/screenshots/Screenshot_20250611-212156.jpg",
      "${_baseUrl}valorant-intel/master/screenshots/Screenshot_20250611-212221.jpg",
    ],
  ),
  proTicTacToe(
    repo: "https://github.com/amiralitaherkhany/pro-tic-tac-toe",
    name: "Pro TicTacToe",
    screenShots: [
      "${_baseUrl}pro-tic-tac-toe/master/screenshots/game_over.jpg",
      "${_baseUrl}pro-tic-tac-toe/master/screenshots/main_screen.jpg",
      "${_baseUrl}pro-tic-tac-toe/master/screenshots/o_turn.jpg",
      "${_baseUrl}pro-tic-tac-toe/master/screenshots/vs_ai.jpg",
      "${_baseUrl}pro-tic-tac-toe/master/screenshots/x_turn.jpg",
    ],
  );

  static const _baseUrl =
      "https://raw.githubusercontent.com/amiralitaherkhany/";
  const ProjectConstants({
    required this.repo,
    required this.name,
    required this.screenShots,
  });
  final String name;
  final String repo;
  final List<String> screenShots;
}
