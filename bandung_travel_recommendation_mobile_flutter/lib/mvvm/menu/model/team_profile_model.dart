class TeamProfileModel {
  String name;
  String nim;
  String? imagePath;
  String linkedInUrl;
  String githubUrl;

  TeamProfileModel({
    required this.name,
    required this.nim,
    this.imagePath,
    required this.linkedInUrl,
    required this.githubUrl,
  });

  static List<TeamProfileModel> TeamsProfile = [
        TeamProfileModel(
          name: "Moch. Nauval Rizaldi N",
          nim: "1301194482",
          imagePath: "https://media-exp1.licdn.com/dms/image/C5603AQHb4RdkFu4JPQ/profile-displayphoto-shrink_200_200/0/1639554561330?e=1657756800&v=beta&t=YdUxwyqLv5jSWugpTlO1DxBiQT1BQFgG2p7xzhgv7uQ",
          linkedInUrl: "https://www.linkedin.com/in/mochnauvalrizaldinasril/",
          githubUrl: "https://github.com/Muvazana",
        ),
        TeamProfileModel(
          name: "Arga Melvern",
          nim: "1301194055",
          imagePath: "https://media-exp1.licdn.com/dms/image/C5603AQHyztlwIJnb0A/profile-displayphoto-shrink_200_200/0/1618813074156?e=1657756800&v=beta&t=oXhlhZxSpCMvZ6DQdeyf217yBW2PxVKpR3cgO5NwyQg",
          linkedInUrl: "https://www.linkedin.com/in/argamelvern/",
          githubUrl: "https://github.com/ArgaMelvern",
        ),
        TeamProfileModel(
          name: "Mohammad Akbar Fauzy",
          nim: "1301194133",
          imagePath: "https://media-exp1.licdn.com/dms/image/C5603AQHqsyFC3SiCHA/profile-displayphoto-shrink_200_200/0/1648209373904?e=1657756800&v=beta&t=c9OW48kJJhtAYo5Heqm7B3khXJWY-4_NeWgSqYFqMf8",
          linkedInUrl: "https://www.linkedin.com/in/akbarfauzy/",
          githubUrl: "https://github.com/AkbarFauzy",
        ),
        TeamProfileModel(
          name: "Jane Raihan",
          nim: "1301194240",
          imagePath: "https://media-exp1.licdn.com/dms/image/C5603AQHKypZRYB0svA/profile-displayphoto-shrink_200_200/0/1647057208371?e=1657756800&v=beta&t=4fs6OHQJy8ob98puE6gnC0nbFbUSiIXDFe9XoADo0rc",
          linkedInUrl: "https://www.linkedin.com/in/jane-raihan-3b7b301bb/",
          githubUrl: "https://github.com/janerhn",
        ),
      ];
}
