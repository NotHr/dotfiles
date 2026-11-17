{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = [ pkgs.vimPlugins.vimwiki ];
    extraConfig = ''
      let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
    '';
  };
}
