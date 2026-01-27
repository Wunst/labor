{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    emmet-language-server
    vscode-langservers-extracted
    httpie
    jq
    serve
  ];
}
