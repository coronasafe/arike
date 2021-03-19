// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as Nanoid from "nanoid";
import * as Belt_Array from "bs-platform/lib/es6/belt_Array.js";

function s(prim) {
  return prim;
}

function make(word) {
  return {
          id: Nanoid.nanoid(),
          word: word
        };
}

function id(t) {
  return t.id;
}

function word(t) {
  return t.word;
}

var Record = {
  make: make,
  id: id,
  word: word
};

function AutoComplete(Props) {
  var getFilteredArray = Props.getFilteredArray;
  var placeholderOpt = Props.placeholder;
  var valueOpt = Props.value;
  var placeholder = placeholderOpt !== undefined ? placeholderOpt : "Start searching";
  var value = valueOpt !== undefined ? valueOpt : "";
  var match = React.useState(function () {
        return value;
      });
  var setInputValue = match[1];
  var inputValue = match[0];
  var match$1 = React.useState(function () {
        return false;
      });
  var setRenderSuggestions = match$1[1];
  var getSuggestions = function (input) {
    var sg = Belt_Array.map(Curry._1(getFilteredArray, input), (function (w) {
            return {
                    id: Nanoid.nanoid(),
                    word: w
                  };
          }));
    if (sg.length < 1) {
      return React.createElement("div", {
                  className: "w-full absolute rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none text-sm text-center py-2"
                }, "No Matches Found");
    } else {
      return React.createElement("div", {
                  "aria-labelledby": "options-menu",
                  className: "z-10 w-full max-h-32 overflow-y-scroll absolute rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5",
                  role: "menu"
                }, React.createElement("ul", {
                      "aria-label": "menu",
                      className: "py-1",
                      role: "menu"
                    }, Belt_Array.map(sg, (function (word) {
                            return React.createElement("li", {
                                        key: word.id,
                                        className: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 focus:bg-gray-100 hover:text-gray-900",
                                        id: word.word,
                                        role: "menuitem",
                                        tabIndex: 0,
                                        onKeyDown: (function ($$event) {
                                            if ($$event.key === "Enter") {
                                              Curry._1(setInputValue, (function (param) {
                                                      return word.word;
                                                    }));
                                              return Curry._1(setRenderSuggestions, (function (param) {
                                                            return false;
                                                          }));
                                            }
                                            
                                          }),
                                        onClick: (function (param) {
                                            Curry._1(setInputValue, (function (param) {
                                                    return word.word;
                                                  }));
                                            return Curry._1(setRenderSuggestions, (function (param) {
                                                          return false;
                                                        }));
                                          })
                                      }, word.word);
                          }))));
    }
  };
  return React.createElement("div", {
              className: "p-8 flex items-center justify-center bg-white"
            }, React.createElement("div", {
                  className: "w-full max-w-xs mx-auto"
                }, React.createElement("div", {
                      className: "relative"
                    }, React.createElement("label", {
                          className: "block text-sm font-medium text-gray-700",
                          htmlFor: "email"
                        }, "Disease"), React.createElement("div", {
                          className: "mt-1"
                        }, React.createElement("input", {
                              "aria-describedby": "disease-description",
                              className: "shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md",
                              id: "diseases",
                              tabIndex: 0,
                              autoComplete: "off",
                              name: "diseases",
                              placeholder: placeholder,
                              type: "search",
                              value: inputValue,
                              onChange: (function ($$event) {
                                  var value = $$event.target.value;
                                  return Curry._1(setInputValue, (function (param) {
                                                var len = value.length;
                                                if (len > 1) {
                                                  Curry._1(setRenderSuggestions, (function (param) {
                                                          return true;
                                                        }));
                                                } else {
                                                  Curry._1(setRenderSuggestions, (function (param) {
                                                          return false;
                                                        }));
                                                }
                                                return value;
                                              }));
                                })
                            })), match$1[0] === true ? getSuggestions(inputValue) : React.createElement(React.Fragment, undefined))));
}

var make$1 = AutoComplete;

export {
  s ,
  Record ,
  make$1 as make,
  
}
/* react Not a pure module */
