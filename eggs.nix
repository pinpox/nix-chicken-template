{ eggDerivation, fetchegg }:
rec {
  aes = eggDerivation {
    name = "aes-1.5";

    src = fetchegg {
      name = "aes";
      version = "1.5";
      sha256 = "0gjlvz5nk0fnaclljpyfk21rkf0nidjj6wcv3jbnpmfafgjny5fi";
    };

    buildInputs = [
      
    ];
  };
}
