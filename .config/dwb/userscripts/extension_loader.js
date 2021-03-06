//!javascript
//<adblock_subscriptions___SCRIPT
extensions.load("adblock_subscriptions", {
//<adblock_subscriptions___CONFIG
// To take effect dwb needs to be restarted

// Shortcut to subscribe to a filterlist
scSubscribe : null, 
// Command to subscribe to a filterlist
cmdSubscribe : "adblock_subscribe", 

// Shortcut to unsubscribe from a filterlist
scUnsubscribe : null, 

// Command to unsubscribe from a filterlist
cmdUnsubscribe : "adblock_unsubscribe",

// Path to the filterlist directory, will be created if it doesn't exist. 
filterListDir : data.configDir + "/adblock_lists"
//>adblock_subscriptions___CONFIG
});
//>adblock_subscriptions___SCRIPT
//<userscripts___SCRIPT
extensions.load("userscripts", {
//<userscripts___CONFIG
  // paths to userscripts, this extension will also load all scripts in 
  // $XDG_CONFIG_HOME/dwb/greasemonkey, it will also load all scripts in
  // $XDG_CONFIG_HOME/dwb/scripts but this is deprecated and will be
  // disabled in future versions.
  scripts : []
//>userscripts___CONFIG
});
//>userscripts___SCRIPT
//<userstyles___SCRIPT
extensions.load("userstyles", {
//<userstyles___CONFIG
  // paths to userstyles, this extension will also load all scripts in
  // $XDG_CONFIG_HOME/dwb/userstyles
  styles : []
//>userstyles___CONFIG
});
//>userstyles___SCRIPT
