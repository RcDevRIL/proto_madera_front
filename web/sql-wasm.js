
// We are modularizing this manually because the current modularize setting in Emscripten has some issues:
// https://github.com/kripken/emscripten/issues/5820
// In addition, When you use emcc's modularization, it still expects to export a global object called `Module`,
// which is able to be used/called before the WASM is loaded.
// The modularization below exports a promise that loads and resolves to the actual sql.js module.
// That way, this module can't be used before the WASM is finished loading.

// We are going to define a function that a user will call to start loading initializing our Sql.js library
// However, that function might be called multiple times, and on subsequent calls, we don't actually want it to instantiate a new instance of the Module
// Instead, we want to return the previously loaded module

// TODO: Make this not declare a global if used in the browser
var initSqlJsPromise = undefined;

var initSqlJs = function (moduleConfig) {

    if (initSqlJsPromise) {
        return initSqlJsPromise;
    }
    // If we're here, we've never called this function before
    initSqlJsPromise = new Promise((resolveModule, reject) => {

        // We are modularizing this manually because the current modularize setting in Emscripten has some issues:
        // https://github.com/kripken/emscripten/issues/5820

        // The way to affect the loading of emcc compiled modules is to create a variable called `Module` and add
        // properties to it, like `preRun`, `postRun`, etc
        // We are using that to get notified when the WASM has finished loading.
        // Only then will we return our promise

        // If they passed in a moduleConfig object, use that
        // Otherwise, initialize Module to the empty object
        var Module = typeof moduleConfig !== 'undefined' ? moduleConfig : {};

        // EMCC only allows for a single onAbort function (not an array of functions)
        // So if the user defined their own onAbort function, we remember it and call it
        var originalOnAbortFunction = Module['onAbort'];
        Module['onAbort'] = function (errorThatCausedAbort) {
            reject(new Error(errorThatCausedAbort));
            if (originalOnAbortFunction) {
                originalOnAbortFunction(errorThatCausedAbort);
            }
        };

        Module['postRun'] = Module['postRun'] || [];
        Module['postRun'].push(function () {
            // When Emscripted calls postRun, this promise resolves with the built Module
            resolveModule(Module);
        });

        // There is a section of code in the emcc-generated code below that looks like this:
        // (Note that this is lowercase `module`)
        // if (typeof module !== 'undefined') {
        //     module['exports'] = Module;
        // }
        // When that runs, it's going to overwrite our own modularization export efforts in shell-post.js!
        // The only way to tell emcc not to emit it is to pass the MODULARIZE=1 or MODULARIZE_INSTANCE=1 flags,
        // but that carries with it additional unnecessary baggage/bugs we don't want either.
        // So, we have three options:
        // 1) We undefine `module`
        // 2) We remember what `module['exports']` was at the beginning of this function and we restore it later
        // 3) We write a script to remove those lines of code as part of the Make process.
        //
        // Since those are the only lines of code that care about module, we will undefine it. It's the most straightforward
        // of the options, and has the side effect of reducing emcc's efforts to modify the module if its output were to change in the future.
        // That's a nice side effect since we're handling the modularization efforts ourselves
        module = undefined;

        // The emcc-generated code and shell-post.js code goes below,
        // meaning that all of it runs inside of this promise. If anything throws an exception, our promise will abort
        var f; f || (f = typeof Module !== 'undefined' ? Module : {});
        var ua = function () {
            var a; var b = h(4); var c = {}; var d = function () {
                function a(a, b) { this.jb = a; this.db = b; this.qb = 1; this.Hb = [] } a.prototype.bind = function (a) { if (!this.jb) throw "Statement closed"; this.reset(); return Array.isArray(a) ? this.cc(a) : this.dc(a) }; a.prototype.step = function () { var a; if (!this.jb) throw "Statement closed"; this.qb = 1; switch (a = ec(this.jb)) { case c.Zb: return !0; case c.DONE: return !1; default: return this.db.handleError(a) } }; a.prototype.kc = function (a) { null == a && (a = this.qb++); return fc(this.jb, a) }; a.prototype.lc =
                    function (a) { null == a && (a = this.qb++); return hc(this.jb, a) }; a.prototype.getBlob = function (a) { var b; null == a && (a = this.qb++); var c = ic(this.jb, a); var d = jc(this.jb, a); var e = new Uint8Array(c); for (a = b = 0; 0 <= c ? b < c : b > c; a = 0 <= c ? ++b : --b)e[a] = l[d + a]; return e }; a.prototype.get = function (a) {
                        var b, d; null != a && this.bind(a) && this.step(); var e = []; a = b = 0; for (d = rb(this.jb); 0 <= d ? b < d : b > d; a = 0 <= d ? ++b : --b)switch (kc(this.jb, a)) {
                            case c.Yb: case c.FLOAT: e.push(this.kc(a)); break; case c.$b: e.push(this.lc(a)); break; case c.Xb: e.push(this.getBlob(a));
                                break; default: e.push(null)
                        }return e
                    }; a.prototype.getColumnNames = function () { var a, b; var c = []; var d = a = 0; for (b = rb(this.jb); 0 <= b ? a < b : a > b; d = 0 <= b ? ++a : --a)c.push(lc(this.jb, d)); return c }; a.prototype.getAsObject = function (a) { var b, c; var d = this.get(a); var e = this.getColumnNames(); var g = {}; a = b = 0; for (c = e.length; b < c; a = ++b) { var wa = e[a]; g[wa] = d[a] } return g }; a.prototype.run = function (a) { null != a && this.bind(a); this.step(); return this.reset() }; a.prototype.hc = function (a, b) {
                        var c; null == b && (b = this.qb++); a = aa(a); this.Hb.push(c =
                            ba(a)); this.db.handleError(J(this.jb, b, c, a.length - 1, 0))
                    }; a.prototype.bc = function (a, b) { var c; null == b && (b = this.qb++); this.Hb.push(c = ba(a)); this.db.handleError(S(this.jb, b, c, a.length, 0)) }; a.prototype.fc = function (a, b) { null == b && (b = this.qb++); this.db.handleError((a === (a | 0) ? mc : nc)(this.jb, b, a)) }; a.prototype.ec = function (a) { null == a && (a = this.qb++); S(this.jb, a, 0, 0, 0) }; a.prototype.Ob = function (a, b) {
                    null == b && (b = this.qb++); switch (typeof a) {
                        case "string": this.hc(a, b); break; case "number": case "boolean": this.fc(a +
                            0, b); break; case "object": if (null === a) this.ec(b); else if (null != a.length) this.bc(a, b); else throw "Wrong API use : tried to bind a value of an unknown type (" + a + ").";
                    }
                    }; a.prototype.dc = function (a) { var b; for (b in a) { var c = a[b]; var d = oc(this.jb, b); 0 !== d && this.Ob(c, d) } return !0 }; a.prototype.cc = function (a) { var b, c; var d = b = 0; for (c = a.length; b < c; d = ++b) { var e = a[d]; this.Ob(e, d + 1) } return !0 }; a.prototype.reset = function () { this.freemem(); return pc(this.jb) === c.Bb && qc(this.jb) === c.Bb }; a.prototype.freemem = function () {
                        for (var a; a =
                            this.Hb.pop();)ca(a); return null
                    }; a.prototype.free = function () { this.freemem(); var a = rc(this.jb) === c.Bb; delete this.db.Fb[this.jb]; this.jb = ja; return a }; return a
            }(); var e = function () {
                function a(a) {
                this.filename = "dbfile_" + (4294967295 * Math.random() >>> 0); if (null != a) {
                    var c = this.filename, d = c ? n("/", c) : "/"; c = da(!0, !0); d = ea(d, (void 0 !== c ? c : 438) & 4095 | 32768, 0); if (a) {
                        if ("string" === typeof a) { for (var e = Array(a.length), k = 0, m = a.length; k < m; ++k)e[k] = a.charCodeAt(k); a = e } fa(d, c | 146); e = p(d, "w"); ha(e, a, 0, a.length, 0, void 0);
                        ia(e); fa(d, c)
                    }
                } this.handleError(g(this.filename, b)); this.db = q(b, "i32"); sc(this.db); this.Fb = {}; this.rb = {}
                } a.prototype.run = function (a, c) { if (!this.db) throw "Database closed"; if (c) { a = this.prepare(a, c); try { a.step() } finally { a.free() } } else this.handleError(m(this.db, a, 0, 0, b)); return this }; a.prototype.exec = function (a) {
                    var c; if (!this.db) throw "Database closed"; var e = ka(); try {
                        var g = la(a) + 1, k = h(g); t(a, l, k, g); var m = k; var v = h(4); for (c = []; q(m, "i8") !== ja;) {
                            ma(b); ma(v); this.handleError(K(this.db, m, -1, b, v)); var wa =
                                q(b, "i32"); m = q(v, "i32"); if (wa !== ja) { var r = null; var J = new d(wa, this); try { for (; J.step();)null === r && (r = { columns: J.getColumnNames(), values: [] }, c.push(r)), r.values.push(J.get()) } finally { J.free() } }
                        } return c
                    } finally { na(e) }
                }; a.prototype.each = function (a, b, c, d) { "function" === typeof b && (d = c, c = b, b = void 0); a = this.prepare(a, b); try { for (; a.step();)c(a.getAsObject()) } finally { a.free() } if ("function" === typeof d) return d() }; a.prototype.prepare = function (a, c) {
                    ma(b); this.handleError(v(this.db, a, -1, b, ja)); a = q(b, "i32"); if (a ===
                        ja) throw "Nothing to prepare"; var e = new d(a, this); null != c && e.bind(c); return this.Fb[a] = e
                }; a.prototype["export"] = function () {
                    var a; var c = this.Fb; for (e in c) { var d = c[e]; d.free() } d = this.rb; for (e in d) c = d[e], u[c - oa] = null; this.rb = {}; this.handleError(k(this.db)); d = this.filename; var e = e = { encoding: "binary" }; e.flags = e.flags || "r"; e.encoding = e.encoding || "binary"; if ("utf8" !== e.encoding && "binary" !== e.encoding) throw Error('Invalid encoding type "' + e.encoding + '"'); c = p(d, e.flags); d = pa(d).size; var m = new Uint8Array(d);
                    qa(c, m, 0, d, 0); "utf8" === e.encoding ? a = ra(m, 0) : "binary" === e.encoding && (a = m); ia(c); this.handleError(g(this.filename, b)); this.db = q(b, "i32"); return a
                }; a.prototype.close = function () { var a; var b = this.Fb; for (a in b) { var c = b[a]; c.free() } c = this.rb; for (a in c) b = c[a], u[b - oa] = null; this.rb = {}; this.handleError(k(this.db)); sa("/" + this.filename); return this.db = null }; a.prototype.handleError = function (a) { if (a === c.Bb) return null; a = tc(this.db); throw Error(a); }; a.prototype.getRowsModified = function () { return r(this.db) }; a.prototype.create_function =
                    function (a, b) {
                    a in this.rb && (u[this.rb[a] - oa] = null, delete this.rb[a]); var d = ta(function (a, c, d) {
                        var e, g; var k = []; for (e = g = 0; 0 <= c ? g < c : g > c; e = 0 <= c ? ++g : --g) { var m = q(d + 4 * e, "i32"); var v = vc(m); e = function () { switch (!1) { case 1 !== v: return wb; case 2 !== v: return wb; case 3 !== v: return wc; case 4 !== v: return function (a) { var b, c; var d = yc(a); var e = zc(a); a = new Uint8Array(d); for (b = c = 0; 0 <= d ? c < d : c > d; b = 0 <= d ? ++c : --c)a[b] = l[e + b]; return a }; default: return function () { return null } } }(); e = e(m); k.push(e) } try { var r = b.apply(null, k) } catch (xc) {
                            r =
                            xc; xb(a, r, -1); return
                        } switch (typeof r) { case "boolean": Ac(a, r ? 1 : 0); break; case "number": Bc(a, r); break; case "string": Cc(a, r, -1, -1); break; case "object": null === r ? yb(a) : null != r.length ? (c = ba(r), Dc(a, c, r.length, -1), ca(c)) : xb(a, "Wrong API use : tried to return a value of an unknown type (" + r + ").", -1); break; default: yb(a) }
                    }); this.rb[a] = d; this.handleError(Ec(this.db, a, b.length, c.ac, 0, d, 0, 0, 0)); return this
                    }; return a
            }(); var g = f.cwrap("sqlite3_open", "number", ["string", "number"]); var k = f.cwrap("sqlite3_close_v2",
                "number", ["number"]); var m = f.cwrap("sqlite3_exec", "number", ["number", "string", "number", "number", "number"]); f.cwrap("sqlite3_free", "", ["number"]); var r = f.cwrap("sqlite3_changes", "number", ["number"]); var v = f.cwrap("sqlite3_prepare_v2", "number", ["number", "string", "number", "number", "number"]); var K = f.cwrap("sqlite3_prepare_v2", "number", ["number", "number", "number", "number", "number"]); var J = f.cwrap("sqlite3_bind_text", "number", ["number", "number", "number", "number", "number"]); var S = f.cwrap("sqlite3_bind_blob",
                    "number", ["number", "number", "number", "number", "number"]); var nc = f.cwrap("sqlite3_bind_double", "number", ["number", "number", "number"]); var mc = f.cwrap("sqlite3_bind_int", "number", ["number", "number", "number"]); var oc = f.cwrap("sqlite3_bind_parameter_index", "number", ["number", "string"]); var ec = f.cwrap("sqlite3_step", "number", ["number"]); var tc = f.cwrap("sqlite3_errmsg", "string", ["number"]); var rb = f.cwrap("sqlite3_data_count", "number", ["number"]); var fc = f.cwrap("sqlite3_column_double", "number", ["number",
                        "number"]); var hc = f.cwrap("sqlite3_column_text", "string", ["number", "number"]); var jc = f.cwrap("sqlite3_column_blob", "number", ["number", "number"]); var ic = f.cwrap("sqlite3_column_bytes", "number", ["number", "number"]); var kc = f.cwrap("sqlite3_column_type", "number", ["number", "number"]); var lc = f.cwrap("sqlite3_column_name", "string", ["number", "number"]); var qc = f.cwrap("sqlite3_reset", "number", ["number"]); var pc = f.cwrap("sqlite3_clear_bindings", "number", ["number"]); var rc = f.cwrap("sqlite3_finalize", "number",
                            ["number"]); var Ec = f.cwrap("sqlite3_create_function_v2", "number", "number string number number number number number number number".split(" ")); var vc = f.cwrap("sqlite3_value_type", "number", ["number"]); var yc = f.cwrap("sqlite3_value_bytes", "number", ["number"]); var wc = f.cwrap("sqlite3_value_text", "string", ["number"]); f.cwrap("sqlite3_value_int", "number", ["number"]); var zc = f.cwrap("sqlite3_value_blob", "number", ["number"]); var wb = f.cwrap("sqlite3_value_double", "number", ["number"]); var Bc = f.cwrap("sqlite3_result_double",
                                "", ["number", "number"]); var yb = f.cwrap("sqlite3_result_null", "", ["number"]); var Cc = f.cwrap("sqlite3_result_text", "", ["number", "string", "number", "number"]); var Dc = f.cwrap("sqlite3_result_blob", "", ["number", "number", "number", "number"]); var Ac = f.cwrap("sqlite3_result_int", "", ["number", "number"]); f.cwrap("sqlite3_result_int64", "", ["number", "number"]); var xb = f.cwrap("sqlite3_result_error", "", ["number", "string", "number"]); var sc = f.cwrap("RegisterExtensionFunctions", "number", ["number"]); this.SQL = { Database: e };
            for (a in this.SQL) f[a] = this.SQL[a]; var ja = 0; c.Bb = 0; c.Ac = 1; c.Dc = 2; c.Nc = 3; c.uc = 4; c.wc = 5; c.Gc = 6; c.NOMEM = 7; c.Qc = 8; c.Ec = 9; c.Fc = 10; c.zc = 11; c.NOTFOUND = 12; c.Cc = 13; c.xc = 14; c.Oc = 15; c.EMPTY = 16; c.Rc = 17; c.Sc = 18; c.yc = 19; c.Hc = 20; c.Ic = 21; c.Jc = 22; c.vc = 23; c.Bc = 24; c.Pc = 25; c.Kc = 26; c.Lc = 27; c.Tc = 28; c.Zb = 100; c.DONE = 101; c.Yb = 1; c.FLOAT = 2; c.$b = 3; c.Xb = 4; c.Mc = 5; c.ac = 1
        }.bind(this); f.onRuntimeInitialized = ua; var va = {}, w; for (w in f) f.hasOwnProperty(w) && (va[w] = f[w]); var xa = "./this.program", ya = !1, x = !1, za = !1, Aa = !1, Ba = !1;
        ya = "object" === typeof window; x = "function" === typeof importScripts; za = (Aa = "object" === typeof process && "object" === typeof process.versions && "string" === typeof process.versions.node) && !ya && !x; Ba = !ya && !za && !x; var y = "", Ca, Da;
        if (za) { y = __dirname + "/"; var Ea, Fa; Ca = function (a, b) { Ea || (Ea = require("fs")); Fa || (Fa = require("path")); a = Fa.normalize(a); a = Ea.readFileSync(a); return b ? a : a.toString() }; Da = function (a) { a = Ca(a, !0); a.buffer || (a = new Uint8Array(a)); assert(a.buffer); return a }; 1 < process.argv.length && (xa = process.argv[1].replace(/\\/g, "/")); process.argv.slice(2); "undefined" !== typeof module && (module.exports = f); process.on("unhandledRejection", z); f.inspect = function () { return "[Emscripten Module object]" } } else if (Ba) "undefined" != typeof read &&
            (Ca = function (a) { return read(a) }), Da = function (a) { if ("function" === typeof readbuffer) return new Uint8Array(readbuffer(a)); a = read(a, "binary"); assert("object" === typeof a); return a }, "undefined" !== typeof print && ("undefined" === typeof console && (console = {}), console.log = print, console.warn = console.error = "undefined" !== typeof printErr ? printErr : print); else if (ya || x) x ? y = self.location.href : document.currentScript && (y = document.currentScript.src), y = 0 !== y.indexOf("blob:") ? y.substr(0, y.lastIndexOf("/") + 1) : "", Ca = function (a) {
                var b =
                    new XMLHttpRequest; b.open("GET", a, !1); b.send(null); return b.responseText
            }, x && (Da = function (a) { var b = new XMLHttpRequest; b.open("GET", a, !1); b.responseType = "arraybuffer"; b.send(null); return new Uint8Array(b.response) }); var Ga = f.print || console.log.bind(console), A = f.printErr || console.warn.bind(console); for (w in va) va.hasOwnProperty(w) && (f[w] = va[w]); va = null; f.thisProgram && (xa = f.thisProgram); function Ha(a) { var b = B[Ia >> 2]; a = b + a + 15 & -16; a > Ja() && z(); B[Ia >> 2] = a; return b }
        var Ka = { "f64-rem": function (a, b) { return a % b }, "debugger": function () { } }, oa = 1, u = Array(64); function ta(a) { for (var b = 0; 64 > b; b++)if (!u[b]) return u[b] = a, oa + b; throw "Finished up all reserved function pointers. Use a higher value for RESERVED_FUNCTION_POINTERS."; } var La; f.wasmBinary && (La = f.wasmBinary); "object" !== typeof WebAssembly && A("no native wasm support detected");
        function ma(a) { var b = "i32"; "*" === b.charAt(b.length - 1) && (b = "i32"); switch (b) { case "i1": l[a >> 0] = 0; break; case "i8": l[a >> 0] = 0; break; case "i16": Ma[a >> 1] = 0; break; case "i32": B[a >> 2] = 0; break; case "i64": C = [0, (D = 0, 1 <= +Na(D) ? 0 < D ? (Oa(+Pa(D / 4294967296), 4294967295) | 0) >>> 0 : ~~+Qa((D - +(~~D >>> 0)) / 4294967296) >>> 0 : 0)]; B[a >> 2] = C[0]; B[a + 4 >> 2] = C[1]; break; case "float": Ra[a >> 2] = 0; break; case "double": Sa[a >> 3] = 0; break; default: z("invalid type for setValue: " + b) } }
        function q(a, b) { b = b || "i8"; "*" === b.charAt(b.length - 1) && (b = "i32"); switch (b) { case "i1": return l[a >> 0]; case "i8": return l[a >> 0]; case "i16": return Ma[a >> 1]; case "i32": return B[a >> 2]; case "i64": return B[a >> 2]; case "float": return Ra[a >> 2]; case "double": return Sa[a >> 3]; default: z("invalid type for getValue: " + b) }return null } var E, Ta = !1; function assert(a, b) { a || z("Assertion failed: " + b) } function Ua(a) { var b = f["_" + a]; assert(b, "Cannot call unknown function " + a + ", make sure it is exported"); return b }
        function Va(a, b, c, d) { var e = { string: function (a) { var b = 0; if (null !== a && void 0 !== a && 0 !== a) { var c = (a.length << 2) + 1; b = h(c); t(a, F, b, c) } return b }, array: function (a) { var b = h(a.length); l.set(a, b); return b } }, g = Ua(a), k = []; a = 0; if (d) for (var m = 0; m < d.length; m++) { var r = e[c[m]]; r ? (0 === a && (a = ka()), k[m] = r(d[m])) : k[m] = d[m] } c = g.apply(null, k); c = function (a) { return "string" === b ? G(a) : "boolean" === b ? !!a : a }(c); 0 !== a && na(a); return c } var Wa = 0, Xa = 3;
        function ba(a) { var b = Wa; if ("number" === typeof a) { var c = !0; var d = a } else c = !1, d = a.length; b = b == Xa ? e : [Ya, h, Ha][b](Math.max(d, 1)); if (c) { var e = b; assert(0 == (b & 3)); for (a = b + (d & -4); e < a; e += 4)B[e >> 2] = 0; for (a = b + d; e < a;)l[e++ >> 0] = 0; return b } a.subarray || a.slice ? F.set(a, b) : F.set(new Uint8Array(a), b); return b } var Za = "undefined" !== typeof TextDecoder ? new TextDecoder("utf8") : void 0;
        function ra(a, b, c) { var d = b + c; for (c = b; a[c] && !(c >= d);)++c; if (16 < c - b && a.subarray && Za) return Za.decode(a.subarray(b, c)); for (d = ""; b < c;) { var e = a[b++]; if (e & 128) { var g = a[b++] & 63; if (192 == (e & 224)) d += String.fromCharCode((e & 31) << 6 | g); else { var k = a[b++] & 63; e = 224 == (e & 240) ? (e & 15) << 12 | g << 6 | k : (e & 7) << 18 | g << 12 | k << 6 | a[b++] & 63; 65536 > e ? d += String.fromCharCode(e) : (e -= 65536, d += String.fromCharCode(55296 | e >> 10, 56320 | e & 1023)) } } else d += String.fromCharCode(e) } return d } function G(a) { return a ? ra(F, a, void 0) : "" }
        function t(a, b, c, d) { if (!(0 < d)) return 0; var e = c; d = c + d - 1; for (var g = 0; g < a.length; ++g) { var k = a.charCodeAt(g); if (55296 <= k && 57343 >= k) { var m = a.charCodeAt(++g); k = 65536 + ((k & 1023) << 10) | m & 1023 } if (127 >= k) { if (c >= d) break; b[c++] = k } else { if (2047 >= k) { if (c + 1 >= d) break; b[c++] = 192 | k >> 6 } else { if (65535 >= k) { if (c + 2 >= d) break; b[c++] = 224 | k >> 12 } else { if (c + 3 >= d) break; b[c++] = 240 | k >> 18; b[c++] = 128 | k >> 12 & 63 } b[c++] = 128 | k >> 6 & 63 } b[c++] = 128 | k & 63 } } b[c] = 0; return c - e }
        function la(a) { for (var b = 0, c = 0; c < a.length; ++c) { var d = a.charCodeAt(c); 55296 <= d && 57343 >= d && (d = 65536 + ((d & 1023) << 10) | a.charCodeAt(++c) & 1023); 127 >= d ? ++b : b = 2047 >= d ? b + 2 : 65535 >= d ? b + 3 : b + 4 } return b } "undefined" !== typeof TextDecoder && new TextDecoder("utf-16le"); function $a(a) { 0 < a % 65536 && (a += 65536 - a % 65536); return a } var buffer, l, F, Ma, B, Ra, Sa;
        function ab(a) { buffer = a; f.HEAP8 = l = new Int8Array(a); f.HEAP16 = Ma = new Int16Array(a); f.HEAP32 = B = new Int32Array(a); f.HEAPU8 = F = new Uint8Array(a); f.HEAPU16 = new Uint16Array(a); f.HEAPU32 = new Uint32Array(a); f.HEAPF32 = Ra = new Float32Array(a); f.HEAPF64 = Sa = new Float64Array(a) } var Ia = 60304, bb = f.TOTAL_MEMORY || 16777216; f.wasmMemory ? E = f.wasmMemory : E = new WebAssembly.Memory({ initial: bb / 65536 }); E && (buffer = E.buffer); bb = buffer.byteLength; ab(buffer); B[Ia >> 2] = 5303216;
        function cb(a) { for (; 0 < a.length;) { var b = a.shift(); if ("function" == typeof b) b(); else { var c = b.jc; "number" === typeof c ? void 0 === b.Ib ? f.dynCall_v(c) : f.dynCall_vi(c, b.Ib) : c(void 0 === b.Ib ? null : b.Ib) } } } var db = [], eb = [], fb = [], gb = [], hb = !1; function ib() { var a = f.preRun.shift(); db.unshift(a) } var Na = Math.abs, Qa = Math.ceil, Pa = Math.floor, Oa = Math.min, H = 0, jb = null, kb = null; f.preloadedImages = {}; f.preloadedAudios = {};
        function lb() { var a = I; return String.prototype.startsWith ? a.startsWith("data:application/octet-stream;base64,") : 0 === a.indexOf("data:application/octet-stream;base64,") } var I = "sql-wasm.wasm"; if (!lb()) { var mb = I; I = f.locateFile ? f.locateFile(mb, y) : y + mb } function nb() { try { if (La) return new Uint8Array(La); if (Da) return Da(I); throw "both async and sync fetching of the wasm failed"; } catch (a) { z(a) } }
        function ob() { return La || !ya && !x || "function" !== typeof fetch ? new Promise(function (a) { a(nb()) }) : fetch(I, { credentials: "same-origin" }).then(function (a) { if (!a.ok) throw "failed to load wasm binary file at '" + I + "'"; return a.arrayBuffer() }).catch(function () { return nb() }) }
        function pb(a) {
            function b(a) { f.asm = a.exports; H--; f.monitorRunDependencies && f.monitorRunDependencies(H); 0 == H && (null !== jb && (clearInterval(jb), jb = null), kb && (a = kb, kb = null, a())) } function c(a) { b(a.instance) } function d(a) { return ob().then(function (a) { return WebAssembly.instantiate(a, e) }).then(a, function (a) { A("failed to asynchronously prepare wasm: " + a); z(a) }) } var e = { env: a, wasi_unstable: a, global: { NaN: NaN, Infinity: Infinity }, "global.Math": Math, asm2wasm: Ka }; H++; f.monitorRunDependencies && f.monitorRunDependencies(H);
            if (f.instantiateWasm) try { return f.instantiateWasm(e, b) } catch (g) { return A("Module.instantiateWasm callback failed with error: " + g), !1 } (function () { if (La || "function" !== typeof WebAssembly.instantiateStreaming || lb() || "function" !== typeof fetch) return d(c); fetch(I, { credentials: "same-origin" }).then(function (a) { return WebAssembly.instantiateStreaming(a, e).then(c, function (a) { A("wasm streaming compile failed: " + a); A("falling back to ArrayBuffer instantiation"); d(c) }) }) })(); return {}
        }
        f.asm = function (a, b) { b.memory = E; b.table = new WebAssembly.Table({ initial: 2688, maximum: 2688, element: "anyfunc" }); b.__memory_base = 1024; b.__table_base = 0; return pb(b) }; var D, C; eb.push({ jc: function () { qb() } }); function sb(a) { return a.replace(/\b__Z[\w\d_]+/g, function (a) { return a === a ? a : a + " [" + a + "]" }) } var L = {};
        function tb(a) {
            if (tb.ub) { var b = B[a >> 2]; var c = B[b >> 2] } else tb.ub = !0, L.USER = L.LOGNAME = "web_user", L.PATH = "/", L.PWD = "/", L.HOME = "/home/web_user", L.LANG = ("object" === typeof navigator && navigator.languages && navigator.languages[0] || "C").replace("-", "_") + ".UTF-8", L._ = xa, c = hb ? Ya(1024) : Ha(1024), b = hb ? Ya(256) : Ha(256), B[b >> 2] = c, B[a >> 2] = b; a = []; var d = 0, e; for (e in L) if ("string" === typeof L[e]) { var g = e + "=" + L[e]; a.push(g); d += g.length } if (1024 < d) throw Error("Environment size exceeded TOTAL_ENV_SIZE!"); for (e = 0; e < a.length; e++) {
                d =
                g = a[e]; for (var k = c, m = 0; m < d.length; ++m)l[k++ >> 0] = d.charCodeAt(m); l[k >> 0] = 0; B[b + 4 * e >> 2] = c; c += g.length + 1
            } B[b + 4 * a.length >> 2] = 0
        } function ub(a, b) { for (var c = 0, d = a.length - 1; 0 <= d; d--) { var e = a[d]; "." === e ? a.splice(d, 1) : ".." === e ? (a.splice(d, 1), c++) : c && (a.splice(d, 1), c--) } if (b) for (; c; c--)a.unshift(".."); return a } function vb(a) { var b = "/" === a.charAt(0), c = "/" === a.substr(-1); (a = ub(a.split("/").filter(function (a) { return !!a }), !b).join("/")) || b || (a = "."); a && c && (a += "/"); return (b ? "/" : "") + a }
        function zb(a) { var b = /^(\/?|)([\s\S]*?)((?:\.{1,2}|[^\/]+?|)(\.[^.\/]*|))(?:[\/]*)$/.exec(a).slice(1); a = b[0]; b = b[1]; if (!a && !b) return "."; b && (b = b.substr(0, b.length - 1)); return a + b } function Ab(a) { if ("/" === a) return "/"; var b = a.lastIndexOf("/"); return -1 === b ? a : a.substr(b + 1) } function Bb() { var a = Array.prototype.slice.call(arguments, 0); return vb(a.join("/")) } function n(a, b) { return vb(a + "/" + b) } function Cb(a) { f.___errno_location && (B[f.___errno_location() >> 2] = a); return a }
        function Db() { for (var a = "", b = !1, c = arguments.length - 1; -1 <= c && !b; c--) { b = 0 <= c ? arguments[c] : "/"; if ("string" !== typeof b) throw new TypeError("Arguments to path.resolve must be strings"); if (!b) return ""; a = b + "/" + a; b = "/" === b.charAt(0) } a = ub(a.split("/").filter(function (a) { return !!a }), !b).join("/"); return (b ? "/" : "") + a || "." } var Eb = []; function Fb(a, b) { Eb[a] = { input: [], output: [], yb: b }; Gb(a, Hb) }
        var Hb = {
            open: function (a) { var b = Eb[a.node.rdev]; if (!b) throw new M(19); a.tty = b; a.seekable = !1 }, close: function (a) { a.tty.yb.flush(a.tty) }, flush: function (a) { a.tty.yb.flush(a.tty) }, read: function (a, b, c, d) { if (!a.tty || !a.tty.yb.Vb) throw new M(6); for (var e = 0, g = 0; g < d; g++) { try { var k = a.tty.yb.Vb(a.tty) } catch (m) { throw new M(5); } if (void 0 === k && 0 === e) throw new M(11); if (null === k || void 0 === k) break; e++; b[c + g] = k } e && (a.node.timestamp = Date.now()); return e }, write: function (a, b, c, d) {
                if (!a.tty || !a.tty.yb.Lb) throw new M(6);
                try { for (var e = 0; e < d; e++)a.tty.yb.Lb(a.tty, b[c + e]) } catch (g) { throw new M(5); } d && (a.node.timestamp = Date.now()); return e
            }
        }, Ib = {
            Vb: function (a) {
                if (!a.input.length) {
                    var b = null; if (za) { var c = Buffer.ub ? Buffer.ub(256) : new Buffer(256), d = 0, e = process.stdin.fd; if ("win32" != process.platform) { var g = !1; try { e = fs.openSync("/dev/stdin", "r"), g = !0 } catch (k) { } } try { d = fs.readSync(e, c, 0, 256, null) } catch (k) { if (-1 != k.toString().indexOf("EOF")) d = 0; else throw k; } g && fs.closeSync(e); 0 < d ? b = c.slice(0, d).toString("utf-8") : b = null } else "undefined" !=
                        typeof window && "function" == typeof window.prompt ? (b = window.prompt("Input: "), null !== b && (b += "\n")) : "function" == typeof readline && (b = readline(), null !== b && (b += "\n")); if (!b) return null; a.input = aa(b, !0)
                } return a.input.shift()
            }, Lb: function (a, b) { null === b || 10 === b ? (Ga(ra(a.output, 0)), a.output = []) : 0 != b && a.output.push(b) }, flush: function (a) { a.output && 0 < a.output.length && (Ga(ra(a.output, 0)), a.output = []) }
        }, Jb = {
            Lb: function (a, b) { null === b || 10 === b ? (A(ra(a.output, 0)), a.output = []) : 0 != b && a.output.push(b) }, flush: function (a) {
            a.output &&
                0 < a.output.length && (A(ra(a.output, 0)), a.output = [])
            }
        }, N = {
            pb: null, mb: function () { return N.createNode(null, "/", 16895, 0) }, createNode: function (a, b, c, d) {
                if (24576 === (c & 61440) || 4096 === (c & 61440)) throw new M(1); N.pb || (N.pb = {
                    dir: { node: { ob: N.fb.ob, lb: N.fb.lb, lookup: N.fb.lookup, zb: N.fb.zb, rename: N.fb.rename, unlink: N.fb.unlink, rmdir: N.fb.rmdir, readdir: N.fb.readdir, symlink: N.fb.symlink }, stream: { sb: N.ib.sb } }, file: {
                        node: { ob: N.fb.ob, lb: N.fb.lb }, stream: {
                            sb: N.ib.sb, read: N.ib.read, write: N.ib.write, Nb: N.ib.Nb, Db: N.ib.Db,
                            Eb: N.ib.Eb
                        }
                    }, link: { node: { ob: N.fb.ob, lb: N.fb.lb, readlink: N.fb.readlink }, stream: {} }, Qb: { node: { ob: N.fb.ob, lb: N.fb.lb }, stream: Kb }
                }); c = Lb(a, b, c, d); O(c.mode) ? (c.fb = N.pb.dir.node, c.ib = N.pb.dir.stream, c.gb = {}) : 32768 === (c.mode & 61440) ? (c.fb = N.pb.file.node, c.ib = N.pb.file.stream, c.kb = 0, c.gb = null) : 40960 === (c.mode & 61440) ? (c.fb = N.pb.link.node, c.ib = N.pb.link.stream) : 8192 === (c.mode & 61440) && (c.fb = N.pb.Qb.node, c.ib = N.pb.Qb.stream); c.timestamp = Date.now(); a && (a.gb[b] = c); return c
            }, Uc: function (a) {
                if (a.gb && a.gb.subarray) {
                    for (var b =
                        [], c = 0; c < a.kb; ++c)b.push(a.gb[c]); return b
                } return a.gb
            }, Vc: function (a) { return a.gb ? a.gb.subarray ? a.gb.subarray(0, a.kb) : new Uint8Array(a.gb) : new Uint8Array }, Rb: function (a, b) { var c = a.gb ? a.gb.length : 0; c >= b || (b = Math.max(b, c * (1048576 > c ? 2 : 1.125) | 0), 0 != c && (b = Math.max(b, 256)), c = a.gb, a.gb = new Uint8Array(b), 0 < a.kb && a.gb.set(c.subarray(0, a.kb), 0)) }, qc: function (a, b) {
                if (a.kb != b) if (0 == b) a.gb = null, a.kb = 0; else {
                    if (!a.gb || a.gb.subarray) {
                        var c = a.gb; a.gb = new Uint8Array(new ArrayBuffer(b)); c && a.gb.set(c.subarray(0, Math.min(b,
                            a.kb)))
                    } else if (a.gb || (a.gb = []), a.gb.length > b) a.gb.length = b; else for (; a.gb.length < b;)a.gb.push(0); a.kb = b
                }
            }, fb: {
                ob: function (a) { var b = {}; b.dev = 8192 === (a.mode & 61440) ? a.id : 1; b.ino = a.id; b.mode = a.mode; b.nlink = 1; b.uid = 0; b.gid = 0; b.rdev = a.rdev; O(a.mode) ? b.size = 4096 : 32768 === (a.mode & 61440) ? b.size = a.kb : 40960 === (a.mode & 61440) ? b.size = a.link.length : b.size = 0; b.atime = new Date(a.timestamp); b.mtime = new Date(a.timestamp); b.ctime = new Date(a.timestamp); b.tb = 4096; b.blocks = Math.ceil(b.size / b.tb); return b }, lb: function (a,
                    b) { void 0 !== b.mode && (a.mode = b.mode); void 0 !== b.timestamp && (a.timestamp = b.timestamp); void 0 !== b.size && N.qc(a, b.size) }, lookup: function () { throw Mb[2]; }, zb: function (a, b, c, d) { return N.createNode(a, b, c, d) }, rename: function (a, b, c) { if (O(a.mode)) { try { var d = Nb(b, c) } catch (g) { } if (d) for (var e in d.gb) throw new M(39); } delete a.parent.gb[a.name]; a.name = c; b.gb[c] = a; a.parent = b }, unlink: function (a, b) { delete a.gb[b] }, rmdir: function (a, b) { var c = Nb(a, b), d; for (d in c.gb) throw new M(39); delete a.gb[b] }, readdir: function (a) {
                        var b =
                            [".", ".."], c; for (c in a.gb) a.gb.hasOwnProperty(c) && b.push(c); return b
                    }, symlink: function (a, b, c) { a = N.createNode(a, b, 41471, 0); a.link = c; return a }, readlink: function (a) { if (40960 !== (a.mode & 61440)) throw new M(22); return a.link }
            }, ib: {
                read: function (a, b, c, d, e) { var g = a.node.gb; if (e >= a.node.kb) return 0; a = Math.min(a.node.kb - e, d); if (8 < a && g.subarray) b.set(g.subarray(e, e + a), c); else for (d = 0; d < a; d++)b[c + d] = g[e + d]; return a }, write: function (a, b, c, d, e, g) {
                    g = !1; if (!d) return 0; a = a.node; a.timestamp = Date.now(); if (b.subarray &&
                        (!a.gb || a.gb.subarray)) { if (g) return a.gb = b.subarray(c, c + d), a.kb = d; if (0 === a.kb && 0 === e) return a.gb = new Uint8Array(b.subarray(c, c + d)), a.kb = d; if (e + d <= a.kb) return a.gb.set(b.subarray(c, c + d), e), d } N.Rb(a, e + d); if (a.gb.subarray && b.subarray) a.gb.set(b.subarray(c, c + d), e); else for (g = 0; g < d; g++)a.gb[e + g] = b[c + g]; a.kb = Math.max(a.kb, e + d); return d
                }, sb: function (a, b, c) { 1 === c ? b += a.position : 2 === c && 32768 === (a.node.mode & 61440) && (b += a.node.kb); if (0 > b) throw new M(22); return b }, Nb: function (a, b, c) {
                    N.Rb(a.node, b + c); a.node.kb =
                        Math.max(a.node.kb, b + c)
                }, Db: function (a, b, c, d, e, g, k) { if (32768 !== (a.node.mode & 61440)) throw new M(19); c = a.node.gb; if (k & 2 || c.buffer !== b && c.buffer !== b.buffer) { if (0 < e || e + d < a.node.kb) c.subarray ? c = c.subarray(e, e + d) : c = Array.prototype.slice.call(c, e, e + d); a = !0; e = b.buffer == l.buffer; d = Ya(d); if (!d) throw new M(12); (e ? l : b).set(c, d) } else a = !1, d = c.byteOffset; return { pc: d, Gb: a } }, Eb: function (a, b, c, d, e) { if (32768 !== (a.node.mode & 61440)) throw new M(19); if (e & 2) return 0; N.ib.write(a, b, 0, d, c, !1); return 0 }
            }
        }, P = {
            Cb: !1, sc: function () {
            P.Cb =
                !!process.platform.match(/^win/); var a = process.binding("constants"); a.fs && (a = a.fs); P.Sb = { 1024: a.O_APPEND, 64: a.O_CREAT, 128: a.O_EXCL, 0: a.O_RDONLY, 2: a.O_RDWR, 4096: a.O_SYNC, 512: a.O_TRUNC, 1: a.O_WRONLY }
            }, Pb: function (a) { return Buffer.alloc ? Buffer.from(a) : new Buffer(a) }, mb: function (a) { assert(Aa); return P.createNode(null, "/", P.Ub(a.Kb.root), 0) }, createNode: function (a, b, c) { if (!O(c) && 32768 !== (c & 61440) && 40960 !== (c & 61440)) throw new M(22); a = Lb(a, b, c); a.fb = P.fb; a.ib = P.ib; return a }, Ub: function (a) {
                try {
                    var b = fs.lstatSync(a);
                    P.Cb && (b.mode = b.mode | (b.mode & 292) >> 2)
                } catch (c) { if (!c.code) throw c; throw new M(-c.hb); } return b.mode
            }, nb: function (a) { for (var b = []; a.parent !== a;)b.push(a.name), a = a.parent; b.push(a.mb.Kb.root); b.reverse(); return Bb.apply(null, b) }, ic: function (a) { a &= -2656257; var b = 0, c; for (c in P.Sb) a & c && (b |= P.Sb[c], a ^= c); if (a) throw new M(22); return b }, fb: {
                ob: function (a) {
                    a = P.nb(a); try { var b = fs.lstatSync(a) } catch (c) { if (!c.code) throw c; throw new M(-c.hb); } P.Cb && !b.tb && (b.tb = 4096); P.Cb && !b.blocks && (b.blocks = (b.size + b.tb - 1) /
                        b.tb | 0); return { dev: b.dev, ino: b.ino, mode: b.mode, nlink: b.nlink, uid: b.uid, gid: b.gid, rdev: b.rdev, size: b.size, atime: b.atime, mtime: b.mtime, ctime: b.ctime, tb: b.tb, blocks: b.blocks }
                }, lb: function (a, b) { var c = P.nb(a); try { void 0 !== b.mode && (fs.chmodSync(c, b.mode), a.mode = b.mode), void 0 !== b.size && fs.truncateSync(c, b.size) } catch (d) { if (!d.code) throw d; throw new M(-d.hb); } }, lookup: function (a, b) { var c = n(P.nb(a), b); c = P.Ub(c); return P.createNode(a, b, c) }, zb: function (a, b, c, d) {
                    a = P.createNode(a, b, c, d); b = P.nb(a); try {
                        O(a.mode) ?
                        fs.mkdirSync(b, a.mode) : fs.writeFileSync(b, "", { mode: a.mode })
                    } catch (e) { if (!e.code) throw e; throw new M(-e.hb); } return a
                }, rename: function (a, b, c) { a = P.nb(a); b = n(P.nb(b), c); try { fs.renameSync(a, b) } catch (d) { if (!d.code) throw d; throw new M(-d.hb); } }, unlink: function (a, b) { a = n(P.nb(a), b); try { fs.unlinkSync(a) } catch (c) { if (!c.code) throw c; throw new M(-c.hb); } }, rmdir: function (a, b) { a = n(P.nb(a), b); try { fs.rmdirSync(a) } catch (c) { if (!c.code) throw c; throw new M(-c.hb); } }, readdir: function (a) {
                    a = P.nb(a); try { return fs.readdirSync(a) } catch (b) {
                        if (!b.code) throw b;
                        throw new M(-b.hb);
                    }
                }, symlink: function (a, b, c) { a = n(P.nb(a), b); try { fs.symlinkSync(c, a) } catch (d) { if (!d.code) throw d; throw new M(-d.hb); } }, readlink: function (a) { var b = P.nb(a); try { return b = fs.readlinkSync(b), b = Ob.relative(Ob.resolve(a.mb.Kb.root), b) } catch (c) { if (!c.code) throw c; throw new M(-c.hb); } }
            }, ib: {
                open: function (a) { var b = P.nb(a.node); try { 32768 === (a.node.mode & 61440) && (a.Ab = fs.openSync(b, P.ic(a.flags))) } catch (c) { if (!c.code) throw c; throw new M(-c.hb); } }, close: function (a) {
                    try {
                    32768 === (a.node.mode & 61440) &&
                        a.Ab && fs.closeSync(a.Ab)
                    } catch (b) { if (!b.code) throw b; throw new M(-b.hb); }
                }, read: function (a, b, c, d, e) { if (0 === d) return 0; try { return fs.readSync(a.Ab, P.Pb(b.buffer), c, d, e) } catch (g) { throw new M(-g.hb); } }, write: function (a, b, c, d, e) { try { return fs.writeSync(a.Ab, P.Pb(b.buffer), c, d, e) } catch (g) { throw new M(-g.hb); } }, sb: function (a, b, c) { if (1 === c) b += a.position; else if (2 === c && 32768 === (a.node.mode & 61440)) try { b += fs.fstatSync(a.Ab).size } catch (d) { throw new M(-d.hb); } if (0 > b) throw new M(22); return b }
            }
        }, Pb = null, Qb = {},
            Q = [], Rb = 1, R = null, Sb = !0, T = {}, M = null, Mb = {};
        function U(a, b) { a = Db("/", a); b = b || {}; if (!a) return { path: "", node: null }; var c = { Tb: !0, Mb: 0 }, d; for (d in c) void 0 === b[d] && (b[d] = c[d]); if (8 < b.Mb) throw new M(40); a = ub(a.split("/").filter(function (a) { return !!a }), !1); var e = Pb; c = "/"; for (d = 0; d < a.length; d++) { var g = d === a.length - 1; if (g && b.parent) break; e = Nb(e, a[d]); c = n(c, a[d]); e.wb && (!g || g && b.Tb) && (e = e.wb.root); if (!g || b.vb) for (g = 0; 40960 === (e.mode & 61440);)if (e = Tb(c), c = Db(zb(c), e), e = U(c, { Mb: b.Mb }).node, 40 < g++) throw new M(40); } return { path: c, node: e } }
        function Ub(a) { for (var b; ;) { if (a === a.parent) return a = a.mb.Wb, b ? "/" !== a[a.length - 1] ? a + "/" + b : a + b : a; b = b ? a.name + "/" + b : a.name; a = a.parent } } function Vb(a, b) { for (var c = 0, d = 0; d < b.length; d++)c = (c << 5) - c + b.charCodeAt(d) | 0; return (a + c >>> 0) % R.length } function Wb(a) { var b = Vb(a.parent.id, a.name); a.xb = R[b]; R[b] = a } function Xb(a) { var b = Vb(a.parent.id, a.name); if (R[b] === a) R[b] = a.xb; else for (b = R[b]; b;) { if (b.xb === a) { b.xb = a.xb; break } b = b.xb } }
        function Nb(a, b) { var c; if (c = (c = Yb(a, "x")) ? c : a.fb.lookup ? 0 : 13) throw new M(c, a); for (c = R[Vb(a.id, b)]; c; c = c.xb) { var d = c.name; if (c.parent.id === a.id && d === b) return c } return a.fb.lookup(a, b) }
        function Lb(a, b, c, d) { Zb || (Zb = function (a, b, c, d) { a || (a = this); this.parent = a; this.mb = a.mb; this.wb = null; this.id = Rb++; this.name = b; this.mode = c; this.fb = {}; this.ib = {}; this.rdev = d }, Zb.prototype = {}, Object.defineProperties(Zb.prototype, { read: { get: function () { return 365 === (this.mode & 365) }, set: function (a) { a ? this.mode |= 365 : this.mode &= -366 } }, write: { get: function () { return 146 === (this.mode & 146) }, set: function (a) { a ? this.mode |= 146 : this.mode &= -147 } } })); a = new Zb(a, b, c, d); Wb(a); return a }
        function O(a) { return 16384 === (a & 61440) } var $b = { r: 0, rs: 1052672, "r+": 2, w: 577, wx: 705, xw: 705, "w+": 578, "wx+": 706, "xw+": 706, a: 1089, ax: 1217, xa: 1217, "a+": 1090, "ax+": 1218, "xa+": 1218 }; function ac(a) { var b = ["r", "w", "rw"][a & 3]; a & 512 && (b += "w"); return b } function Yb(a, b) { if (Sb) return 0; if (-1 === b.indexOf("r") || a.mode & 292) { if (-1 !== b.indexOf("w") && !(a.mode & 146) || -1 !== b.indexOf("x") && !(a.mode & 73)) return 13 } else return 13; return 0 } function bc(a, b) { try { return Nb(a, b), 17 } catch (c) { } return Yb(a, "wx") }
        function cc(a, b, c) { try { var d = Nb(a, b) } catch (e) { return e.hb } if (a = Yb(a, "wx")) return a; if (c) { if (!O(d.mode)) return 20; if (d === d.parent || "/" === Ub(d)) return 16 } else if (O(d.mode)) return 21; return 0 } function dc(a) { var b = 4096; for (a = a || 0; a <= b; a++)if (!Q[a]) return a; throw new M(24); }
        function uc(a, b) { Fc || (Fc = function () { }, Fc.prototype = {}, Object.defineProperties(Fc.prototype, { object: { get: function () { return this.node }, set: function (a) { this.node = a } } })); var c = new Fc, d; for (d in a) c[d] = a[d]; a = c; b = dc(b); a.fd = b; return Q[b] = a } var Kb = { open: function (a) { a.ib = Qb[a.node.rdev].ib; a.ib.open && a.ib.open(a) }, sb: function () { throw new M(29); } }; function Gb(a, b) { Qb[a] = { ib: b } }
        function Gc(a, b) { var c = "/" === b, d = !b; if (c && Pb) throw new M(16); if (!c && !d) { var e = U(b, { Tb: !1 }); b = e.path; e = e.node; if (e.wb) throw new M(16); if (!O(e.mode)) throw new M(20); } b = { type: a, Kb: {}, Wb: b, oc: [] }; a = a.mb(b); a.mb = b; b.root = a; c ? Pb = a : e && (e.wb = b, e.mb && e.mb.oc.push(b)) } function ea(a, b, c) { var d = U(a, { parent: !0 }).node; a = Ab(a); if (!a || "." === a || ".." === a) throw new M(22); var e = bc(d, a); if (e) throw new M(e); if (!d.fb.zb) throw new M(1); return d.fb.zb(d, a, b, c) } function V(a, b) { ea(a, (void 0 !== b ? b : 511) & 1023 | 16384, 0) }
        function Hc(a, b, c) { "undefined" === typeof c && (c = b, b = 438); ea(a, b | 8192, c) } function Ic(a, b) { if (!Db(a)) throw new M(2); var c = U(b, { parent: !0 }).node; if (!c) throw new M(2); b = Ab(b); var d = bc(c, b); if (d) throw new M(d); if (!c.fb.symlink) throw new M(1); c.fb.symlink(c, b, a) }
        function sa(a) { var b = U(a, { parent: !0 }).node, c = Ab(a), d = Nb(b, c), e = cc(b, c, !1); if (e) throw new M(e); if (!b.fb.unlink) throw new M(1); if (d.wb) throw new M(16); try { T.willDeletePath && T.willDeletePath(a) } catch (g) { console.log("FS.trackingDelegate['willDeletePath']('" + a + "') threw an exception: " + g.message) } b.fb.unlink(b, c); Xb(d); try { if (T.onDeletePath) T.onDeletePath(a) } catch (g) { console.log("FS.trackingDelegate['onDeletePath']('" + a + "') threw an exception: " + g.message) } }
        function Tb(a) { a = U(a).node; if (!a) throw new M(2); if (!a.fb.readlink) throw new M(22); return Db(Ub(a.parent), a.fb.readlink(a)) } function pa(a, b) { a = U(a, { vb: !b }).node; if (!a) throw new M(2); if (!a.fb.ob) throw new M(1); return a.fb.ob(a) } function Jc(a) { return pa(a, !0) } function fa(a, b) { var c; "string" === typeof a ? c = U(a, { vb: !0 }).node : c = a; if (!c.fb.lb) throw new M(1); c.fb.lb(c, { mode: b & 4095 | c.mode & -4096, timestamp: Date.now() }) }
        function Kc(a) { var b; "string" === typeof a ? b = U(a, { vb: !0 }).node : b = a; if (!b.fb.lb) throw new M(1); b.fb.lb(b, { timestamp: Date.now() }) } function Lc(a, b) { if (0 > b) throw new M(22); var c; "string" === typeof a ? c = U(a, { vb: !0 }).node : c = a; if (!c.fb.lb) throw new M(1); if (O(c.mode)) throw new M(21); if (32768 !== (c.mode & 61440)) throw new M(22); if (a = Yb(c, "w")) throw new M(a); c.fb.lb(c, { size: b, timestamp: Date.now() }) }
        function p(a, b, c, d) {
            if ("" === a) throw new M(2); if ("string" === typeof b) { var e = $b[b]; if ("undefined" === typeof e) throw Error("Unknown file open mode: " + b); b = e } c = b & 64 ? ("undefined" === typeof c ? 438 : c) & 4095 | 32768 : 0; if ("object" === typeof a) var g = a; else { a = vb(a); try { g = U(a, { vb: !(b & 131072) }).node } catch (k) { } } e = !1; if (b & 64) if (g) { if (b & 128) throw new M(17); } else g = ea(a, c, 0), e = !0; if (!g) throw new M(2); 8192 === (g.mode & 61440) && (b &= -513); if (b & 65536 && !O(g.mode)) throw new M(20); if (!e && (c = g ? 40960 === (g.mode & 61440) ? 40 : O(g.mode) &&
                ("r" !== ac(b) || b & 512) ? 21 : Yb(g, ac(b)) : 2)) throw new M(c); b & 512 && Lc(g, 0); b &= -641; d = uc({ node: g, path: Ub(g), flags: b, seekable: !0, position: 0, ib: g.ib, tc: [], error: !1 }, d); d.ib.open && d.ib.open(d); !f.logReadFiles || b & 1 || (Mc || (Mc = {}), a in Mc || (Mc[a] = 1, console.log("FS.trackingDelegate error on read file: " + a))); try { T.onOpenFile && (g = 0, 1 !== (b & 2097155) && (g |= 1), 0 !== (b & 2097155) && (g |= 2), T.onOpenFile(a, g)) } catch (k) { console.log("FS.trackingDelegate['onOpenFile']('" + a + "', flags) threw an exception: " + k.message) } return d
        }
        function ia(a) { if (null === a.fd) throw new M(9); a.Jb && (a.Jb = null); try { a.ib.close && a.ib.close(a) } catch (b) { throw b; } finally { Q[a.fd] = null } a.fd = null } function Nc(a, b, c) { if (null === a.fd) throw new M(9); if (!a.seekable || !a.ib.sb) throw new M(29); if (0 != c && 1 != c && 2 != c) throw new M(22); a.position = a.ib.sb(a, b, c); a.tc = [] }
        function qa(a, b, c, d, e) { if (0 > d || 0 > e) throw new M(22); if (null === a.fd) throw new M(9); if (1 === (a.flags & 2097155)) throw new M(9); if (O(a.node.mode)) throw new M(21); if (!a.ib.read) throw new M(22); var g = "undefined" !== typeof e; if (!g) e = a.position; else if (!a.seekable) throw new M(29); b = a.ib.read(a, b, c, d, e); g || (a.position += b); return b }
        function ha(a, b, c, d, e, g) { if (0 > d || 0 > e) throw new M(22); if (null === a.fd) throw new M(9); if (0 === (a.flags & 2097155)) throw new M(9); if (O(a.node.mode)) throw new M(21); if (!a.ib.write) throw new M(22); a.flags & 1024 && Nc(a, 0, 2); var k = "undefined" !== typeof e; if (!k) e = a.position; else if (!a.seekable) throw new M(29); b = a.ib.write(a, b, c, d, e, g); k || (a.position += b); try { if (a.path && T.onWriteToFile) T.onWriteToFile(a.path) } catch (m) { console.log("FS.trackingDelegate['onWriteToFile']('" + a.path + "') threw an exception: " + m.message) } return b }
        function Oc() { M || (M = function (a, b) { this.node = b; this.rc = function (a) { this.hb = a }; this.rc(a); this.message = "FS error" }, M.prototype = Error(), M.prototype.constructor = M, [2].forEach(function (a) { Mb[a] = new M(a); Mb[a].stack = "<generic error, no stack>" })) } var Pc; function da(a, b) { var c = 0; a && (c |= 365); b && (c |= 146); return c }
        function Qc(a, b, c) {
            a = n("/dev", a); var d = da(!!b, !!c); Rc || (Rc = 64); var e = Rc++ << 8 | 0; Gb(e, { open: function (a) { a.seekable = !1 }, close: function () { c && c.buffer && c.buffer.length && c(10) }, read: function (a, c, d, e) { for (var g = 0, k = 0; k < e; k++) { try { var m = b() } catch (S) { throw new M(5); } if (void 0 === m && 0 === g) throw new M(11); if (null === m || void 0 === m) break; g++; c[d + k] = m } g && (a.node.timestamp = Date.now()); return g }, write: function (a, b, d, e) { for (var g = 0; g < e; g++)try { c(b[d + g]) } catch (K) { throw new M(5); } e && (a.node.timestamp = Date.now()); return g } });
            Hc(a, d, e)
        } var Rc, W = {}, Zb, Fc, Mc, Sc = {};
        function Tc(a, b, c) {
            try { var d = a(b) } catch (e) { if (e && e.node && vb(b) !== vb(Ub(e.node))) return -20; throw e; } B[c >> 2] = d.dev; B[c + 4 >> 2] = 0; B[c + 8 >> 2] = d.ino; B[c + 12 >> 2] = d.mode; B[c + 16 >> 2] = d.nlink; B[c + 20 >> 2] = d.uid; B[c + 24 >> 2] = d.gid; B[c + 28 >> 2] = d.rdev; B[c + 32 >> 2] = 0; C = [d.size >>> 0, (D = d.size, 1 <= +Na(D) ? 0 < D ? (Oa(+Pa(D / 4294967296), 4294967295) | 0) >>> 0 : ~~+Qa((D - +(~~D >>> 0)) / 4294967296) >>> 0 : 0)]; B[c + 40 >> 2] = C[0]; B[c + 44 >> 2] = C[1]; B[c + 48 >> 2] = 4096; B[c + 52 >> 2] = d.blocks; B[c + 56 >> 2] = d.atime.getTime() / 1E3 | 0; B[c + 60 >> 2] = 0; B[c + 64 >> 2] = d.mtime.getTime() /
                1E3 | 0; B[c + 68 >> 2] = 0; B[c + 72 >> 2] = d.ctime.getTime() / 1E3 | 0; B[c + 76 >> 2] = 0; C = [d.ino >>> 0, (D = d.ino, 1 <= +Na(D) ? 0 < D ? (Oa(+Pa(D / 4294967296), 4294967295) | 0) >>> 0 : ~~+Qa((D - +(~~D >>> 0)) / 4294967296) >>> 0 : 0)]; B[c + 80 >> 2] = C[0]; B[c + 84 >> 2] = C[1]; return 0
        } var X = 0; function Y() { X += 4; return B[X - 4 >> 2] } function Z() { return G(Y()) } function Uc() { var a = Q[Y()]; if (!a) throw new M(9); return a } function Ja() { return l.length }
        function Vc(a) { if (0 === a) return 0; a = G(a); if (!L.hasOwnProperty(a)) return 0; Vc.ub && ca(Vc.ub); a = L[a]; var b = la(a) + 1, c = Ya(b); c && t(a, l, c, b); Vc.ub = c; return Vc.ub } t("GMT", F, 60208, 4);
        function Wc() { function a(a) { return (a = a.toTimeString().match(/\(([A-Za-z ]+)\)$/)) ? a[1] : "GMT" } if (!Xc) { Xc = !0; B[Yc() >> 2] = 60 * (new Date).getTimezoneOffset(); var b = new Date(2E3, 0, 1), c = new Date(2E3, 6, 1); B[Zc() >> 2] = Number(b.getTimezoneOffset() != c.getTimezoneOffset()); var d = a(b), e = a(c); d = ba(aa(d)); e = ba(aa(e)); c.getTimezoneOffset() < b.getTimezoneOffset() ? (B[$c() >> 2] = d, B[$c() + 4 >> 2] = e) : (B[$c() >> 2] = e, B[$c() + 4 >> 2] = d) } } var Xc;
        function ad(a) { a /= 1E3; if ((ya || x) && self.performance && self.performance.now) for (var b = self.performance.now(); self.performance.now() - b < a;); else for (b = Date.now(); Date.now() - b < a;); return 0 } f._usleep = ad; Oc(); R = Array(4096); Gc(N, "/"); V("/tmp"); V("/home"); V("/home/web_user");
        (function () {
            V("/dev"); Gb(259, { read: function () { return 0 }, write: function (a, b, c, k) { return k } }); Hc("/dev/null", 259); Fb(1280, Ib); Fb(1536, Jb); Hc("/dev/tty", 1280); Hc("/dev/tty1", 1536); if ("object" === typeof crypto && "function" === typeof crypto.getRandomValues) { var a = new Uint8Array(1); var b = function () { crypto.getRandomValues(a); return a[0] } } else if (za) try { var c = require("crypto"); b = function () { return c.randomBytes(1)[0] } } catch (d) { } b || (b = function () { z("random_device") }); Qc("random", b); Qc("urandom", b); V("/dev/shm");
            V("/dev/shm/tmp")
        })(); V("/proc"); V("/proc/self"); V("/proc/self/fd"); Gc({ mb: function () { var a = Lb("/proc/self", "fd", 16895, 73); a.fb = { lookup: function (a, c) { var b = Q[+c]; if (!b) throw new M(9); a = { parent: null, mb: { Wb: "fake" }, fb: { readlink: function () { return b.path } } }; return a.parent = a } }; return a } }, "/proc/self/fd"); if (Aa) { var fs = require("fs"), Ob = require("path"); P.sc() } function aa(a, b) { var c = Array(la(a) + 1); a = t(a, c, 0, c.length); b && (c.length = a); return c }
        var dd = f.asm({}, {
            n: z, l: function (a) { return u[a]() }, i: function (a, b) { return u[a](b) }, h: function (a, b, c) { return u[a](b, c) }, g: function (a, b, c, d) { return u[a](b, c, d) }, f: function (a, b, c, d, e) { return u[a](b, c, d, e) }, e: function (a, b, c, d, e, g) { return u[a](b, c, d, e, g) }, d: function (a, b, c, d, e, g, k) { return u[a](b, c, d, e, g, k) }, C: function (a, b, c, d, e, g, k) { return u[a](b, c, d, e, g, k) }, B: function (a, b, c, d, e) { return u[a](b, c, d, e) }, A: function (a, b, c) { return u[a](b, c) }, z: function (a, b, c, d) { return u[a](b, c, d) }, y: function (a, b, c, d, e) {
                return u[a](b,
                    c, d, e)
            }, c: function (a, b) { u[a](b) }, b: function (a, b, c) { u[a](b, c) }, k: function (a, b, c, d) { u[a](b, c, d) }, j: function (a, b, c, d, e) { u[a](b, c, d, e) }, x: function (a, b, c, d, e, g) { u[a](b, c, d, e, g) }, w: function (a, b, c, d) { u[a](b, c, d) }, v: function (a, b, c, d) { u[a](b, c, d) }, m: function (a, b, c, d) { z("Assertion failed: " + G(a) + ", at: " + [b ? G(b) : "unknown filename", c, d ? G(d) : "unknown function"]) }, ha: tb, u: Cb, ga: function (a, b) { X = b; try { var c = Z(); sa(c); return 0 } catch (d) { return "undefined" !== typeof W && d instanceof M || z(d), -d.hb } }, fa: function (a, b) {
                X =
                b; try { var c = Uc(); return c.ib && c.ib.fsync ? -c.ib.fsync(c) : 0 } catch (d) { return "undefined" !== typeof W && d instanceof M || z(d), -d.hb }
            }, ea: function (a, b) {
                X = b; try { var c = Uc(), d = Y(), e = Y(), g = Y(), k = Y(); a = 4294967296 * d + (e >>> 0); if (-9007199254740992 >= a || 9007199254740992 <= a) return -75; Nc(c, a, k); C = [c.position >>> 0, (D = c.position, 1 <= +Na(D) ? 0 < D ? (Oa(+Pa(D / 4294967296), 4294967295) | 0) >>> 0 : ~~+Qa((D - +(~~D >>> 0)) / 4294967296) >>> 0 : 0)]; B[g >> 2] = C[0]; B[g + 4 >> 2] = C[1]; c.Jb && 0 === a && 0 === k && (c.Jb = null); return 0 } catch (m) {
                    return "undefined" !== typeof W &&
                        m instanceof M || z(m), -m.hb
                }
            }, da: function (a, b) { X = b; try { var c = Z(), d = Y(); fa(c, d); return 0 } catch (e) { return "undefined" !== typeof W && e instanceof M || z(e), -e.hb } }, ca: function (a, b) { X = b; try { var c = Y(), d = Y(); if (0 === d) return -22; if (d < la("/") + 1) return -34; t("/", F, c, d); return c } catch (e) { return "undefined" !== typeof W && e instanceof M || z(e), -e.hb } }, ba: function (a, b) {
                X = b; try {
                    var c = Y(), d = Y(), e = Y(), g = Y(), k = Y(); a: {
                        var m = Y(); m <<= 12; a = !1; if (0 !== (g & 16) && 0 !== c % 16384) var r = -22; else {
                            if (0 !== (g & 32)) {
                                var v = bd(16384, d); if (!v) {
                                    r = -12;
                                    break a
                                } cd(v, 0, d); a = !0
                            } else { var K = Q[k]; if (!K) { r = -9; break a } b = F; if (0 !== (e & 2) && 0 === (g & 2) && 2 !== (K.flags & 2097155)) throw new M(13); if (1 === (K.flags & 2097155)) throw new M(13); if (!K.ib.Db) throw new M(19); var J = K.ib.Db(K, b, c, d, m, e, g); v = J.pc; a = J.Gb } Sc[v] = { nc: v, mc: d, Gb: a, fd: k, flags: g }; r = v
                        }
                    } return r
                } catch (S) { return "undefined" !== typeof W && S instanceof M || z(S), -S.hb }
            }, aa: function (a, b) {
                X = b; try { var c = Y(); Y(); var d = Y(); Y(); var e = Q[c]; if (!e) throw new M(9); if (0 === (e.flags & 2097155)) throw new M(22); Lc(e.node, d); return 0 } catch (g) {
                    return "undefined" !==
                        typeof W && g instanceof M || z(g), -g.hb
                }
            }, t: function (a, b) { X = b; try { var c = Z(), d = Y(); return Tc(pa, c, d) } catch (e) { return "undefined" !== typeof W && e instanceof M || z(e), -e.hb } }, $: function (a, b) { X = b; try { var c = Z(), d = Y(); return Tc(Jc, c, d) } catch (e) { return "undefined" !== typeof W && e instanceof M || z(e), -e.hb } }, _: function (a, b) { X = b; try { var c = Uc(), d = Y(); return Tc(pa, c.path, d) } catch (e) { return "undefined" !== typeof W && e instanceof M || z(e), -e.hb } }, Z: function (a, b) { X = b; return 42 }, Y: function (a, b) { X = b; return 0 }, X: function (a, b) {
                X =
                b; try { var c = Y(); Y(); Y(); var d = Q[c]; if (!d) throw new M(9); Kc(d.node); return 0 } catch (e) { return "undefined" !== typeof W && e instanceof M || z(e), -e.hb }
            }, W: function (a, b) { X = b; try { var c = Z(); Y(); Y(); Kc(c); return 0 } catch (d) { return "undefined" !== typeof W && d instanceof M || z(d), -d.hb } }, o: function (a, b) {
                X = b; try {
                    var c = Uc(); switch (Y()) {
                        case 0: var d = Y(); return 0 > d ? -22 : p(c.path, c.flags, 0, d).fd; case 1: case 2: return 0; case 3: return c.flags; case 4: return d = Y(), c.flags |= d, 0; case 12: return d = Y(), Ma[d + 0 >> 1] = 2, 0; case 13: case 14: return 0;
                        case 16: case 8: return -22; case 9: return Cb(22), -1; default: return -22
                    }
                } catch (e) { return "undefined" !== typeof W && e instanceof M || z(e), -e.hb }
            }, V: function (a, b) { X = b; try { var c = Uc(), d = Y(), e = Y(); return qa(c, l, d, e) } catch (g) { return "undefined" !== typeof W && g instanceof M || z(g), -g.hb } }, U: function (a, b) {
                X = b; try { var c = Z(); var d = Y(); if (d & -8) var e = -22; else { var g; (g = U(c, { vb: !0 }).node) ? (a = "", d & 4 && (a += "r"), d & 2 && (a += "w"), d & 1 && (a += "x"), e = a && Yb(g, a) ? -13 : 0) : e = -2 } return e } catch (k) {
                    return "undefined" !== typeof W && k instanceof M ||
                        z(k), -k.hb
                }
            }, T: function (a, b) { X = b; try { var c = Z(), d = Y(); a = c; a = vb(a); "/" === a[a.length - 1] && (a = a.substr(0, a.length - 1)); V(a, d); return 0 } catch (e) { return "undefined" !== typeof W && e instanceof M || z(e), -e.hb } }, S: function (a, b) { X = b; try { var c = Uc(), d = Y(), e = Y(); return ha(c, l, d, e) } catch (g) { return "undefined" !== typeof W && g instanceof M || z(g), -g.hb } }, R: function (a, b) {
                X = b; try {
                    var c = Z(), d = U(c, { parent: !0 }).node, e = Ab(c), g = Nb(d, e), k = cc(d, e, !0); if (k) throw new M(k); if (!d.fb.rmdir) throw new M(1); if (g.wb) throw new M(16); try {
                    T.willDeletePath &&
                        T.willDeletePath(c)
                    } catch (m) { console.log("FS.trackingDelegate['willDeletePath']('" + c + "') threw an exception: " + m.message) } d.fb.rmdir(d, e); Xb(g); try { if (T.onDeletePath) T.onDeletePath(c) } catch (m) { console.log("FS.trackingDelegate['onDeletePath']('" + c + "') threw an exception: " + m.message) } return 0
                } catch (m) { return "undefined" !== typeof W && m instanceof M || z(m), -m.hb }
            }, Q: function (a, b) { X = b; try { var c = Z(), d = Y(), e = Y(); return p(c, d, e).fd } catch (g) { return "undefined" !== typeof W && g instanceof M || z(g), -g.hb } }, s: function (a,
                b) { X = b; try { var c = Uc(); ia(c); return 0 } catch (d) { return "undefined" !== typeof W && d instanceof M || z(d), -d.hb } }, P: function (a, b) { X = b; try { var c = Z(), d = Y(); var e = Y(); if (0 >= e) var g = -22; else { var k = Tb(c), m = Math.min(e, la(k)), r = l[d + m]; t(k, F, d, e + 1); l[d + m] = r; g = m } return g } catch (v) { return "undefined" !== typeof W && v instanceof M || z(v), -v.hb } }, O: function (a, b) {
                    X = b; try {
                        var c = Y(), d = Y(); if (-1 === c || 0 === d) var e = -22; else {
                            var g = Sc[c]; if (g && d === g.mc) {
                                var k = Q[g.fd], m = g.flags, r = new Uint8Array(F.subarray(c, c + d)); k && k.ib.Eb && k.ib.Eb(k,
                                    r, 0, d, m); Sc[c] = null; g.Gb && ca(g.nc)
                            } e = 0
                        } return e
                    } catch (v) { return "undefined" !== typeof W && v instanceof M || z(v), -v.hb }
                }, N: function (a, b) { X = b; try { var c = Y(), d = Y(), e = Q[c]; if (!e) throw new M(9); fa(e.node, d); return 0 } catch (g) { return "undefined" !== typeof W && g instanceof M || z(g), -g.hb } }, M: Ja, L: function (a, b, c) { F.set(F.subarray(b, b + c), a) }, K: function (a) {
                    if (2147418112 < a) return !1; for (var b = Math.max(Ja(), 16777216); b < a;)536870912 >= b ? b = $a(2 * b) : b = Math.min($a((3 * b + 2147483648) / 4), 2147418112); a: {
                        try {
                            E.grow(b - buffer.byteLength +
                                65535 >> 16); ab(E.buffer); var c = 1; break a
                        } catch (d) { } c = void 0
                    } return c ? !0 : !1
                }, r: Vc, q: function (a) { var b = Date.now(); B[a >> 2] = b / 1E3 | 0; B[a + 4 >> 2] = b % 1E3 * 1E3 | 0; return 0 }, J: function (a) { return Math.log(a) / Math.LN10 }, p: function () { z("trap!") }, I: function (a) {
                    Wc(); a = new Date(1E3 * B[a >> 2]); B[15040] = a.getSeconds(); B[15041] = a.getMinutes(); B[15042] = a.getHours(); B[15043] = a.getDate(); B[15044] = a.getMonth(); B[15045] = a.getFullYear() - 1900; B[15046] = a.getDay(); var b = new Date(a.getFullYear(), 0, 1); B[15047] = (a.getTime() - b.getTime()) /
                        864E5 | 0; B[15049] = -(60 * a.getTimezoneOffset()); var c = (new Date(2E3, 6, 1)).getTimezoneOffset(); b = b.getTimezoneOffset(); a = (c != b && a.getTimezoneOffset() == Math.min(b, c)) | 0; B[15048] = a; a = B[$c() + (a ? 4 : 0) >> 2]; B[15050] = a; return 60160
                }, H: function (a, b) { if (0 === a) return Cb(22), -1; var c = B[a >> 2]; a = B[a + 4 >> 2]; if (0 > a || 999999999 < a || 0 > c) return Cb(22), -1; 0 !== b && (B[b >> 2] = 0, B[b + 4 >> 2] = 0); return ad(1E6 * c + a / 1E3) }, G: function (a) {
                    switch (a) {
                        case 30: return 16384; case 85: return 131068; case 132: case 133: case 12: case 137: case 138: case 15: case 235: case 16: case 17: case 18: case 19: case 20: case 149: case 13: case 10: case 236: case 153: case 9: case 21: case 22: case 159: case 154: case 14: case 77: case 78: case 139: case 80: case 81: case 82: case 68: case 67: case 164: case 11: case 29: case 47: case 48: case 95: case 52: case 51: case 46: return 200809;
                        case 79: return 0; case 27: case 246: case 127: case 128: case 23: case 24: case 160: case 161: case 181: case 182: case 242: case 183: case 184: case 243: case 244: case 245: case 165: case 178: case 179: case 49: case 50: case 168: case 169: case 175: case 170: case 171: case 172: case 97: case 76: case 32: case 173: case 35: return -1; case 176: case 177: case 7: case 155: case 8: case 157: case 125: case 126: case 92: case 93: case 129: case 130: case 131: case 94: case 91: return 1; case 74: case 60: case 69: case 70: case 4: return 1024; case 31: case 42: case 72: return 32;
                        case 87: case 26: case 33: return 2147483647; case 34: case 1: return 47839; case 38: case 36: return 99; case 43: case 37: return 2048; case 0: return 2097152; case 3: return 65536; case 28: return 32768; case 44: return 32767; case 75: return 16384; case 39: return 1E3; case 89: return 700; case 71: return 256; case 40: return 255; case 2: return 100; case 180: return 64; case 25: return 20; case 5: return 16; case 6: return 6; case 73: return 4; case 84: return "object" === typeof navigator ? navigator.hardwareConcurrency || 1 : 1
                    }Cb(22); return -1
                },
            F: function (a) { var b = Date.now() / 1E3 | 0; a && (B[a >> 2] = b); return b }, E: function (a, b) { if (b) { var c = 1E3 * B[b + 8 >> 2]; c += B[b + 12 >> 2] / 1E3 } else c = Date.now(); a = G(a); try { b = c; var d = U(a, { vb: !0 }).node; d.fb.lb(d, { timestamp: Math.max(b, c) }); return 0 } catch (e) { a = e; if (!(a instanceof M)) { a += " : "; a: { d = Error(); if (!d.stack) { try { throw Error(0); } catch (g) { d = g } if (!d.stack) { d = "(no stack trace available)"; break a } } d = d.stack.toString() } f.extraStackTrace && (d += "\n" + f.extraStackTrace()); d = sb(d); throw a + d; } Cb(a.hb); return -1 } }, D: function () { z("OOM") },
            a: Ia
        }, buffer); f.asm = dd; f._RegisterExtensionFunctions = function () { return f.asm.ia.apply(null, arguments) }; var qb = f.___emscripten_environ_constructor = function () { return f.asm.ja.apply(null, arguments) }; f.___errno_location = function () { return f.asm.ka.apply(null, arguments) };
        var Zc = f.__get_daylight = function () { return f.asm.la.apply(null, arguments) }, Yc = f.__get_timezone = function () { return f.asm.ma.apply(null, arguments) }, $c = f.__get_tzname = function () { return f.asm.na.apply(null, arguments) }, ca = f._free = function () { return f.asm.oa.apply(null, arguments) }, Ya = f._malloc = function () { return f.asm.pa.apply(null, arguments) }, bd = f._memalign = function () { return f.asm.qa.apply(null, arguments) }, cd = f._memset = function () { return f.asm.ra.apply(null, arguments) };
        f._sqlite3_bind_blob = function () { return f.asm.sa.apply(null, arguments) }; f._sqlite3_bind_double = function () { return f.asm.ta.apply(null, arguments) }; f._sqlite3_bind_int = function () { return f.asm.ua.apply(null, arguments) }; f._sqlite3_bind_parameter_index = function () { return f.asm.va.apply(null, arguments) }; f._sqlite3_bind_text = function () { return f.asm.wa.apply(null, arguments) }; f._sqlite3_changes = function () { return f.asm.xa.apply(null, arguments) }; f._sqlite3_clear_bindings = function () { return f.asm.ya.apply(null, arguments) };
        f._sqlite3_close_v2 = function () { return f.asm.za.apply(null, arguments) }; f._sqlite3_column_blob = function () { return f.asm.Aa.apply(null, arguments) }; f._sqlite3_column_bytes = function () { return f.asm.Ba.apply(null, arguments) }; f._sqlite3_column_double = function () { return f.asm.Ca.apply(null, arguments) }; f._sqlite3_column_name = function () { return f.asm.Da.apply(null, arguments) }; f._sqlite3_column_text = function () { return f.asm.Ea.apply(null, arguments) }; f._sqlite3_column_type = function () { return f.asm.Fa.apply(null, arguments) };
        f._sqlite3_create_function_v2 = function () { return f.asm.Ga.apply(null, arguments) }; f._sqlite3_data_count = function () { return f.asm.Ha.apply(null, arguments) }; f._sqlite3_errmsg = function () { return f.asm.Ia.apply(null, arguments) }; f._sqlite3_exec = function () { return f.asm.Ja.apply(null, arguments) }; f._sqlite3_finalize = function () { return f.asm.Ka.apply(null, arguments) }; f._sqlite3_free = function () { return f.asm.La.apply(null, arguments) }; f._sqlite3_open = function () { return f.asm.Ma.apply(null, arguments) };
        f._sqlite3_prepare_v2 = function () { return f.asm.Na.apply(null, arguments) }; f._sqlite3_reset = function () { return f.asm.Oa.apply(null, arguments) }; f._sqlite3_result_blob = function () { return f.asm.Pa.apply(null, arguments) }; f._sqlite3_result_double = function () { return f.asm.Qa.apply(null, arguments) }; f._sqlite3_result_error = function () { return f.asm.Ra.apply(null, arguments) }; f._sqlite3_result_int = function () { return f.asm.Sa.apply(null, arguments) }; f._sqlite3_result_int64 = function () { return f.asm.Ta.apply(null, arguments) };
        f._sqlite3_result_null = function () { return f.asm.Ua.apply(null, arguments) }; f._sqlite3_result_text = function () { return f.asm.Va.apply(null, arguments) }; f._sqlite3_step = function () { return f.asm.Wa.apply(null, arguments) }; f._sqlite3_value_blob = function () { return f.asm.Xa.apply(null, arguments) }; f._sqlite3_value_bytes = function () { return f.asm.Ya.apply(null, arguments) }; f._sqlite3_value_double = function () { return f.asm.Za.apply(null, arguments) }; f._sqlite3_value_int = function () { return f.asm._a.apply(null, arguments) };
        f._sqlite3_value_text = function () { return f.asm.$a.apply(null, arguments) }; f._sqlite3_value_type = function () { return f.asm.ab.apply(null, arguments) }; var h = f.stackAlloc = function () { return f.asm.cb.apply(null, arguments) }, na = f.stackRestore = function () { return f.asm.db.apply(null, arguments) }, ka = f.stackSave = function () { return f.asm.eb.apply(null, arguments) }; f.dynCall_vi = function () { return f.asm.bb.apply(null, arguments) }; f.asm = dd;
        f.cwrap = function (a, b, c, d) { c = c || []; var e = c.every(function (a) { return "number" === a }); return "string" !== b && e && !d ? Ua(a) : function () { return Va(a, b, c, arguments) } }; f.stackSave = ka; f.stackRestore = na; f.stackAlloc = h; var ed; kb = function fd() { ed || gd(); ed || (kb = fd) };
        function gd() {
            function a() {
                if (!ed && (ed = !0, !Ta)) {
                    hb = !0; f.noFSInit || Pc || (Pc = !0, Oc(), f.stdin = f.stdin, f.stdout = f.stdout, f.stderr = f.stderr, f.stdin ? Qc("stdin", f.stdin) : Ic("/dev/tty", "/dev/stdin"), f.stdout ? Qc("stdout", null, f.stdout) : Ic("/dev/tty", "/dev/stdout"), f.stderr ? Qc("stderr", null, f.stderr) : Ic("/dev/tty1", "/dev/stderr"), p("/dev/stdin", "r"), p("/dev/stdout", "w"), p("/dev/stderr", "w")); cb(eb); Sb = !1; cb(fb); if (f.onRuntimeInitialized) f.onRuntimeInitialized(); if (f.postRun) for ("function" == typeof f.postRun &&
                        (f.postRun = [f.postRun]); f.postRun.length;) { var a = f.postRun.shift(); gb.unshift(a) } cb(gb)
                }
            } if (!(0 < H)) { if (f.preRun) for ("function" == typeof f.preRun && (f.preRun = [f.preRun]); f.preRun.length;)ib(); cb(db); 0 < H || (f.setStatus ? (f.setStatus("Running..."), setTimeout(function () { setTimeout(function () { f.setStatus("") }, 1); a() }, 1)) : a()) }
        } f.run = gd; function z(a) { if (f.onAbort) f.onAbort(a); Ga(a); A(a); Ta = !0; throw "abort(" + a + "). Build with -s ASSERTIONS=1 for more info."; } f.abort = z;
        if (f.preInit) for ("function" == typeof f.preInit && (f.preInit = [f.preInit]); 0 < f.preInit.length;)f.preInit.pop()(); gd();


        // The shell-pre.js and emcc-generated code goes above
        return Module;
    }); // The end of the promise being returned

    return initSqlJsPromise;
} // The end of our initSqlJs function

// This bit below is copied almost exactly from what you get when you use the MODULARIZE=1 flag with emcc
// However, we don't want to use the emcc modularization. See shell-pre.js
if (typeof exports === 'object' && typeof module === 'object') {
    module.exports = initSqlJs;
    // This will allow the module to be used in ES6 or CommonJS
    module.exports.default = initSqlJs;
}
else if (typeof define === 'function' && define['amd']) {
    define([], function () { return initSqlJs; });
}
else if (typeof exports === 'object') {
    exports["Module"] = initSqlJs;
}

