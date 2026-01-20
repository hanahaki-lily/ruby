TOKEN = ENV['CLIENT_TOKEN']
PREFIX = '!'

EMBED_COLOR = 0x9B111E

DEVELOPER_IDS = ["325512370107580417"]

XP_COOLDOWN = 10
DAILY_GEMS = 50
DAILY_COOLDOWN = 86_400
GEMS_PER_LEVEL = 10

LEVEL_ROLES = {
  5  => "Twilight Wanderer",
  10 => "Crescent Ascendant",
  20 => "Starlit Voyager",
  30 => "Lunar Adept",
  50 => "Eclipse Paragon"
}

# ---------------- Cards ----------------

AMIIBO_CARDS = [
  { name: "Isabelle", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/isabelle-737c40e71ee1d2a769460fb80b7b8a4efd6ecfdc2094228325b27c0227b25eec.png" },
  { name: "Tom Nook", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/tom-nook-d5f33139e0c214f67e8a72b0e1a5449db37c191060eaf2af7fed4c6c0d01c068.png" },
  { name: "DJ KK", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/dj-kk-6838a113012f939eceb0f87f088961998cecf3392009b898070a06d0dc8df1ec.png" },
  { name: "Sable", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/sable-4a6c08d661261b2112e5ab8f85a306b706ad25cc822a16ace546e2c33805883f.png" },
  { name: "Kapp'n", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/kapp-n-4fe163ea9be6114802cb21cab9593c17179229ff246bed78129e81fe897ce666.png" },
  { name: "Resetti", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/resetti-b78996304d7a2c905e5426c6df7ba119e903d890ae06d1e9f6d42a713ff0877b.png" },
  { name: "Joan", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/joan-cd4b43bc2573ccb5dbea9b2699cacadfdfa75b447d47401b6050625e3a1a95c6.png" },
  { name: "Timmy", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/timmy-c29ed195bb1055b1b7b2d3b31079ee73df20f5e7c8293c8c84b10202170c01c2.png" },
  { name: "Digby", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/digby-9009944c55ebdfd545f3ee69e728b799b27896c20bd2faec634770d2993f7ec9.png" },
  { name: "Pascal", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/pascal-09ec5f2fd4b04515601c6d0e9a6bbe6ed84b04a64302eb5c52f1014e2150cd2f.png" },
  { name: "Harriet", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/harriet-45ae89f221bea68d9dbeb198a8f76eda319776b83b08fe8afece94e46ba02beb.png" },
  { name: "Redd", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/redd-09c5398eb443f2802378cc9ce6bc8f4f0c579e7dacf3d410ffdad72dab9ba302.png" },
  { name: "Saharah", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/saharah-09fada0ae0b4f5997e7064f434aad148e67253d2869db15b2fdf836fb3aa71d4.png" },
  { name: "Luna", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/luna-7c22fd429137bda8b90c3fb5dc58e45bbd66164f82244dfdc1ef8f9e5d215aad.png" },
  { name: "Tortimer", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/tortimer-aecd34609c3db082b2d292fc11881632c2e6df43f71f58b7e9bbb8f17da5167a.png" },
  { name: "Lyle", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/lyle-6760d24c74956dc79e8919d42091b69b303fed82184456105fb0bde354e21853.png" },
  { name: "Lottie", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/lottie-6c1a61f010f48e8e6f0fd3f6213926d02cb264a7ea3b9c0e00793aa1e186410c.png" },
  { name: "Bob", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/bob-f43b00d5c852a5b4a60cef13ee69400ccd49d1c93dc9403556c2debb415eec1b.png" },
  { name: "Fauna", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/fauna-ecae38114593b4b3262704833282f7c174c4198025b0e4b637348cd0aa57f440.png" },
  { name: "Curt", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/curt-4a401988f821e7aa72fb012412d7a3ba5ee9699956b562cd1417bbd91747ab39.png" },
  { name: "Portia", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/portia-525d5493eb07718e8592c9dbfb2c71ad8a703dce6a9d19f6e4d9bba87b9d47a4.png" },
  { name: "Leonardo", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/leonardo-01b1ce44b835a4cc0b837f8b38d22df00705812ffa6d5448ccf42a394524759d.png" },
  { name: "Cheri", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/cheri-db7c3fa0de547d6c469b7373aca97c1867a5f042bdc7de7bd5cfd6f5703e4f8a.png" },
  { name: "Kyle", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/kyle-eb3d9c10c1ddfa69c66f2c311fb8ad890aed6836bf2cf7406fffc0712e3b07bc.png" },
  { name: "Al", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/al-b57f20e4b9b4e4c6029bc03559fb26fa25ab36bfa1cd0a6ec77dab8abb1184ee.png" },
  { name: "Renée", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/renee-26ea4d61e53b78eadcbf0b6473cd21d981828ad9debe145db54e099cfc5f0487.png" },
  { name: "Lopez", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/lopez-ba1e7319ce04ca59d702953efdd6849d7e18b510eba5ebacdb669cfabe9621c0.png" },
  { name: "Jambette", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/jambette-4c563b92fe1366709af65cfaf07bd23d75156d528ddf1f1351b6a22246fab73d.png" },
  { name: "Rasher", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/rasher-222642357ca27dce5d4dde4a65f9a671b095c3af84d5cabc62f4c4d3c45f22b9.png" },
  { name: "Tiffany", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/tiffany-0cbbc0d51603ce73f7c5882e4e76718d65aa15b3c5e13e4d8182bd4869172cc1.png" },
  { name: "Sheldon", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/sheldon-d13a4978f6672c1b43df93b21aff09e781c919abaa743500c6a905abd76ca38b.png" },
  { name: "Bluebear", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/bluebear-cf44a5d4d362f048b79a07f0029683ef436946f54472ea91cae39fc4218b5bf0.png" },
  { name: "Bill", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/bill-5029d5833838ac8865e3d5fd04d3dd36003f45e24a1b723db2a3178aa3ea96a4.png" },
  { name: "Kiki", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/kiki-d67f8b7e4abe1f4106df292be97f54f81756ce3c27d9aa6c13e0f03035e5ab3b.png" },
  { name: "Deli", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/deli-f6b3f5be66b169731be0a3183a029b5c8f3cf6149aa43862ac431ff1c9a40f1f.png" },
  { name: "Alli", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/alli-4dfc87089c5a05e0a4902537d0c03fb53ca10b791688afd17fd6abf361e73c5f.png" },
  { name: "Kabuki", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/kabuki-0b8055597ab974e34c347fcbfaf31c73fe2023f1c2f887ef755e1c6b8fc91045.png" },
  { name: "Patty", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/patty-2fe7923e2216bfd679d4333223f06663b4abbe669bc192f7599f3839f322de78.png" },
  { name: "Jitters", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/jitters-9e1ab2d453dc2e4e8736080320f682bf7b52c784107cdcb4f5fbca397ddae501.png" },
  { name: "Gigi", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/gigi-1bafcff22ff8647f2093d670c96de313da02f7f864857d16e9f5556ddc64533d.png" },
  { name: "Quillson", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/quillson-23dd0d685afc55a6d7ee2c67d10c5c313ba7b5fbbc647457395532ca50124aaa.png" },
  { name: "Marcie", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/marcie-85a6e9aa64849758e5f02bccdd8e9dfb1d5375282ebc0a3028f680e06d591b34.png" },
  { name: "Puck", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/puck-80bcd1bee4a70e0eae2279af0c1651b1381f5a0bd286386cccaf9067e6c1a78c.png" },
  { name: "Shari", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/shari-081ba5d2e57e97c3615dd3a167af16a2830d1959ada2b3120ad723387df890c0.png" },
  { name: "Octavian", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/octavian-7f14f7c40b9e00b17b8cee593a041eb638fd3cdcb0278caf7c0056a4c373f2b0.png" },
  { name: "Winnie", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/winnie-b2a1447064247f70b6a0201dd983fa316d50f1d6a39a008f9cfbd35998cc52c5.png" },
  { name: "Knox", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/knox-ce53eec4bb087c60dd79cc6323002066187ac4799300ef185899aa64f536cdda.png" },
  { name: "Sterling", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/sterling-0f8df7aec50109b7120052ca4df0dc4cb6348acd6c3007bcadebcc4d0f021c1e.png" },
  { name: "Bonbon", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/bonbon-bd655f90260efef5bc9d7e04bb04f38eb0737acd31cb90ce16f0e35ba91f8601.png" },
  { name: "Punchy", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/punchy-94617190aa279c0507ce412f5fa11b6f8d4a8f413f29c75ad8d1e11be6ba4dd4.png" },
  { name: "Opal", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/opal-592acc45e5354f205e5b640590e5518a87d52053ed666040e69686e71b10eb0b.png" },
  { name: "Poppy", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/poppy-80aa70fb5cbdeac7bc6c53e221ae50761d4dcf41d721303dc07161a69f1bd2bd.png" },
  { name: "Limburg", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/limberg-2e16e7d34ac68f142da733b24315a1d890a41a7e9cb0a76bc1fb1a30ec58944e.png" },
  { name: "Deena", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/deena-eaa2e843eb12cd516e3db2649a54c544998db79b373f69a17001be0a469ad59c.png" },
  { name: "Snake", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/snake-9a1e4c784af6a288414de9e12626aec221c85719a0c6c1dc10eb678404614671.png" },
  { name: "Bangle", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/bangle-844ac979a650e1ee2697e2454275cef6273645a48c93d0418f3a6a06656b80d0.png" },
  { name: "Phil", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/phil-a8f01088e9fca3bb5f15292f5970e972e125b6591c95c2a26847d6698a45e07b.png" },
  { name: "Monique", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/monique-2ea31cec5cb0cdc5be72320af64b4eb7bbd1be320e75d9844ece40d761574e53.png" },
  { name: "Nate", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/nate-9edea8c51a57c63f957ec52097733b5dc9f0a65f528612e1725e7f7f1be7cca5.png" },
  { name: "Samson", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/samson-8c0239dcfbd5cb2cb3b4f52d6b6b90040429d142165d7f7b34463e69e629ae35.png" },
  { name: "Tutu", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/tutu-07cd8821804eb5aeb33d860d8528300021090508a25b8fbf7a93297769855e3a.png" },
  { name: "T-Bone", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/t-bone-1bca338b9fd72d7c715aaa580685d68cfb7f54da1955d2ce4e52bd70e28b13f2.png" },
  { name: "Mint", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/mint-4ac1c0554b67b037c9203a4632deb136f359dafbe11a851959df65eb27517ef1.png" },
  { name: "Pudge", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/pudge-80de08f3f1f15cb739a287c2207714706683fb1058a3935748fd2108ae150638.png" },
  { name: "Midge", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/midge-33b52350e77505bee158c95aafc48e9839e8c8baf079bdb41f601f25fe5ac0cb.png" },
  { name: "Gruff", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/gruff-878e6042fa20cf9e1656d49cda071417a2a1803a221f7d62ff2c9a40f9b1c5df.png" },
  { name: "Flurry", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/flurry-b317e83e8d3e5616d64299bade93020c421d6248bf223b07ac2ef16a08c91e5c.png" },
  { name: "Clyde", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/clyde-130b9875d9f4376097e02a4068a1f3e97504ab4666d8ba845fde6f228376c270.png" },
  { name: "Bella", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/bella-7c9fc0c6b21779e5f42fe840c9dbb2854557d33c3b59c05997fae1d9a30942e4.png" },
  { name: "Biff", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/biff-4508a506555f2fef84044dfaca61f3d7b04b4681d53d7fb84b62b4a5a11fde44.png" },
  { name: "Yuka", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/yuka-99a8c7afb1d1a02c3a483dbb154c20f8587c72ee47ba1a03e2e66fb401204e6b.png" },
  { name: "Lionel", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/lionel-cf7bde5305ddc6e0286ab73af2f42b1dc9f28eb59b836871d884837fc34d8670.png" },
  { name: "Flo", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/flo-c1691571efd5f29ba503775e028bf99ba736acefb1f09f7e06df41bfa40a5ee7.png" },
  { name: "Cobb", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/cobb-094792693cdd46405e05cfde0e7a06a4399d725d38e96a325b8561136134862d.png" },
  { name: "Amelia", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/amelia-7bc24669afcfee15dfd4bd5f8ce08e620241c9ba0cc0e9ff500f16cb32093377.png" },
  { name: "Jeremiah", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/jeremiah-dc7bdc444b5470c6dee17ed7a60bfa4615294a0dbae74ec7b8ea8215399d7f9a.png" },
  { name: "Cherry", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/cherry-9a828034718b5aef2023dfba5b00e6f2b22722250110c1e9d0d115a758de20e2.png" },
  { name: "Roscoe", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/roscoe-ca1464decc60aba43b825880a8f3257ca83442830aaaf0658fda2ffb2e55fbb1.png" },
  { name: "Truffles", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/truffles-c396ddff1c6e7fcf6769771242074cbd409ab63eeff3479cd0b968bb2980ae9f.png" },
  { name: "Eugene", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/eugene-2e28d797b1f895db4a5dc9049bc8e4b8d5d7c57e2c6b858b25d8ae2aff8f4b0d.png" },
  { name: "Eunice", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/eunice-6d4ebd1dca36ddb8170455394deddfa8ec86f70d584212019d0f44f8e9612426.png" },
  { name: "Goose", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/goose-a224042e42c2f5550b1322a4d39225e3b36c3e53a4898042d50def9194b7c9fa.png" },
  { name: "Annalisa", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/annalisa-ce9fa12c356ff88a6d7ac7ebef6e779592c0236f0925ef8bd16137ea89674c76.png" },
  { name: "Benjamin", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/benjamin-c5474d44e94e5b3248753cef8383b7331a115095ee23383376c161a73534e35a.png" },
  { name: "Pancetti", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/pancetti-6dac0971589f07dbc05007c1feafd67366b794652ebe2862ba6362e15f383793.png" },
  { name: "Chief", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/chief-85b17df0a091c1bd84c822716c84c48bd68503ce5485996a36ec50eeb86c136f.png" },
  { name: "Bunnie", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/bunnie-ba2b71ea939afb25bd497622b1671f6761488684863643cc476e0159b7344cfe.png" },
  { name: "Clay", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/clay-24127f101ac85097fc9e4a8b9598ec15c6cc2c169e3696c503a7e7df1946681f.png" },
  { name: "Diana", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/diana-97eaf3d59993d4c8ad5a43769d564a93d72f8101bc4ce00a4c02a0f0025f0941.png" },
  { name: "Axel", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/axel-1006b4ef5df7367ad13e9a2b1c5e99239d4e78f531803dd55eead80236be06a1.png" },
  { name: "Muffy", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/muffy-a1be05c83dd0463c40c16a14503cbf76b268870e63a833f4dfd0ccf6a79e88df.png" },
  { name: "Henry", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/henry-16ef22fb0218cfd0b1ef69ee000248e9d183e7f2b2b2e6008548aaed356b56fd.png" },
  { name: "Bertha", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/bertha-95c9b252485ca5155dbb45d24bde7b5ad8a2f2bbafce37543a372097df5ca9e9.png" },
  { name: "Cyrano", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/cyrano-37a89d45288fc6021fc9a29516e0d9935b26aeef6632abf82786615e4a5a05a5.png" },
  { name: "Peanut", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/peanut-bcc613ce10fbc701282c6ff39f9c8e60ca60e7d53eb08e033e21dd730b64a037.png" },
  { name: "Cole", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/cole-dfb9ecfac0cfc388b476e38a554ea31f5ab5b5dc8b21141de3771e92c3c33edb.png" },
  { name: "Willow", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/willow-52edd98ceefbfda1661ade8f8792be882108793af933246fe5b3d8365ba530d6.png" },
  { name: "Roald", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/roald-0617ee4f09470d9dff3c4ff07699c8ca537760ce0a62389f742c4ef32783867d.png" },
  { name: "Molly", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/molly-99ac3561575c9b4421c527b987e65271394e93fa5421e84d71ca6309020bd35b.png" },
  { name: "Walker", image: "https://amiibo.life/assets/figures/amiibo/animal-crossing-cards-series-1/walker-8fca0003881b309ff6a2b8eb90eb9e9f966008f281a245c1dd771718879f2d9b.png" }
]
CARD_COST = 50
TOTAL_CARDS = AMIIBO_CARDS.size

# ---------------- COLOR ROLES ----------------

ALLOWED_COLORS = [
  "RoseQuartz", "Amethyst", "Malachite", "Sapphire", "Ruby",
  "Aquamarine", "Diamond", "Onyx", "Amber", "Jade"
].map(&:downcase)

# ---------------- HUG MESSAGES ----------------

HUG_MESSAGES = [
  "wraps them in a warm hug ❤️",
  "pulls them close under the moonlight 🌙❤️",
  "gives the softest, coziest hug ✨❤️",
  "holds them tight with gentle care 🌸❤️",
  "shares a comforting hug full of love 💖"
]