{
home.file.".config/starship.toml".text = ''
add_newline = false

# Replace the "❯" symbol in the prompt with "➜"
[character]      # The name of the module we are configuring is "character"
symbol = "➜"     # The "symbol" segment is being set to "➜"

# Disable the package module, hiding it from the prompt completely
[package]
disabled = false

[username]
style_user = "bold green"
'';
}
