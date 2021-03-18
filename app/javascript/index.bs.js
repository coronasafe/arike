// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as ReactDom from "react-dom";
import * as AutoComplete$Arike from "./AutoComplete/AutoComplete.bs.js";

function s(prim) {
  return prim;
}

function runReact(root) {
  var root$1 = document.querySelector("#" + root);
  if (root$1 == null) {
    console.log("hunu");
  } else {
    ReactDom.render(React.createElement(AutoComplete$Arike.make, {
              getFilteredArray: (function (inputValue) {
                  return [
                            "euma",
                            "euvid",
                            "euian",
                            "eubert",
                            "euwyoski",
                            "euugo",
                            "droka",
                            "daran",
                            "eugi"
                          ].filter(function (el) {
                              return el.includes(inputValue);
                            });
                }),
              placeholder: "Diseases",
              value: ""
            }), root$1);
  }
  
}

export {
  s ,
  runReact ,
  
}
/* react Not a pure module */
