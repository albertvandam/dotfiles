"use strict";

const fs = require("fs");

const homePath = process.env.HOMEPATH;
const homeDrive = process.env.HOMEDRIVE;

const template = JSON.parse(
    fs.readFileSync(
        `${homePath}/.config/Install/Windows/WindowsTerminal/template.json`,
        "utf-8"
    )
);
const actual = JSON.parse(
    fs.readFileSync(
        `${homePath}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json`
    )
);

apply(template, actual);

let defaultGUID = undefined;
const visible = [];
template.profiles.list.forEach((element) => {
    actual.profiles.list.forEach((target) => {
        if (element.name === target.name && element.source === target.source) {
            Object.keys(element).forEach((key) => {
                if (key === "default") {
                    defaultGUID = target.guid;
                } else {
                    target[key] = element[key];
                }
            });

            if (target.backgroundImage) {
                target.backgroundImage = target.backgroundImage.replace(
                    "%HOME%",
                    `${homeDrive}${homePath}`
                );
            }

            visible.push(`${element.name}:${element.source}`);
        }
    });
});

if (defaultGUID) {
    actual.defaultProfile = defaultGUID;
}

template.profiles.list.forEach((element) => {
    actual.profiles.list.forEach((target) => {
        if (!visible.includes(`${target.name}:${target.source}`)) {
            target.colorScheme = "Amber-theme";
            target.cursorShape = "vintage";
            target["experimental.retroTerminalEffect"] = true;
            target.font = {
                face: "BigBlueTerm437 Nerd Font Mono",
                size: 16.0,
            };
            target.hidden = true;
            target.suppressApplicationTitle = true;
            target.tabTitle = target.name;
        }
    });
});

fs.writeFileSync(
    `${homePath}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json`,
    JSON.stringify(actual, null, 4),
    "utf-8"
);

function apply(template, actual) {
    Object.keys(template).forEach((key) => {
        if (key !== "list") {
            if (typeof template[key] === "object") {
                if (!actual[key]) {
                    if (Array.isArray(template[key])) {
                        actual[key] = [];
                    } else {
                        actual[key] = {};
                    }
                }
                apply(template[key], actual[key]);
            } else {
                actual[key] = template[key];
            }
        }
    });
}
