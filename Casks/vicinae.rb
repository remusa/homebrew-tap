cask("vicinae") do
 version("0.28.2")
 sha256("005e348dce03f50ab6bc6a4d8e05d09fcc0216a846b607dbc02e4a9168fa7aa9")
 url("https://github.com/vicinaehq/vicinae/releases/download/v#{version}/Vicinae.dmg")

 name("Vicinae")
 desc("A focused launcher for your desktop")
 homepage("https://vicinae.com")

 app("Vicinae.app")

 zap(
 trash: [
   "~/Library/Application Support/Vicinae",
   "~/Library/Preferences/com.vicinae.app.plist",
   "~/Library/Saved Application State/com.vicinae.app.savedState",
 ]
 )
end
