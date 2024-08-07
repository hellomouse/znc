#!/usr/bin/env perl
#
# Copyright (C) 2004-2024 ZNC, see the NOTICE file for details.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Parts of SWIG are used here.

use strict;
use warnings;
use IO::File;
use feature 'switch', 'say';

open my $in, $ARGV[0] or die;
open my $out, ">", $ARGV[1] or die;

print $out <<'EOF';
/*
 * Copyright (C) 2004-2024 ZNC, see the NOTICE file for details.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Parts of SWIG are used here.
 */

/***************************************************************************
 * This file is generated automatically using codegen.pl from functions.in *
 * Don't change it manually.                                               *
 ***************************************************************************/

namespace {
	inline swig_type_info* ZNC_SWIG_pchar_descriptor(void) {
		static int init = 0;
		static swig_type_info* info = 0;
		if (!init) {
			info = SWIG_TypeQuery("_p_char");
			init = 1;
		}
		return info;
	}

// SWIG 4.2.0 replaced SWIG_Python_str_AsChar with SWIG_PyUnicode_AsUTF8AndSize.
// SWIG doesn't provide any good way to detect SWIG version (other than parsing
// `swig -version`), but it also introduced SWIG_NULLPTR in 4.2.0.
// So let's abuse that define to do different code for new SWIG.
#ifdef SWIG_NULLPTR
	// This is copied/adapted from SWIG 4.2.0 from pystrings.swg
	inline int ZNC_SWIG_AsCharPtrAndSize(PyObject *obj, char** cptr, size_t* psize, int *alloc) {
#if PY_VERSION_HEX>=0x03000000
#if defined(SWIG_PYTHON_STRICT_BYTE_CHAR)
		if (PyBytes_Check(obj))
#else
		if (PyUnicode_Check(obj))
#endif
#else
		if (PyString_Check(obj))
#endif
		{
			char *cstr; Py_ssize_t len;
			PyObject *bytes = NULL;
			int ret = SWIG_OK;
			if (alloc)
				*alloc = SWIG_OLDOBJ;
#if PY_VERSION_HEX>=0x03000000 && defined(SWIG_PYTHON_STRICT_BYTE_CHAR)
			if (PyBytes_AsStringAndSize(obj, &cstr, &len) == -1)
				return SWIG_TypeError;
#else
			cstr = (char *)SWIG_PyUnicode_AsUTF8AndSize(obj, &len, &bytes);
			if (!cstr)
				return SWIG_TypeError;
			/* The returned string is only duplicated if the char * returned is not owned and memory managed by obj */
			if (bytes && cptr) {
				if (alloc) {
					//cstr = %new_copy_array(cstr, len + 1, char);
					cstr = (char *)memcpy((char *)malloc((len + 1)*sizeof(char)), cstr, sizeof(char)*(len + 1));
					*alloc = SWIG_NEWOBJ;
				} else {
					/* alloc must be set in order to clean up allocated memory */
					return SWIG_RuntimeError;
				}
			}
#endif
			if (cptr) *cptr = cstr;
			if (psize) *psize = len + 1;
			Py_XDECREF(bytes);
			return ret;
		} else {
			swig_type_info* pchar_descriptor = ZNC_SWIG_pchar_descriptor();
			if (pchar_descriptor) {
				void* vptr = 0;
				if (SWIG_ConvertPtr(obj, &vptr, pchar_descriptor, 0) == SWIG_OK) {
					if (cptr) *cptr = (char *) vptr;
					if (psize) *psize = vptr ? (strlen((char *)vptr) + 1) : 0;
					if (alloc) *alloc = SWIG_OLDOBJ;
					return SWIG_OK;
				}
			}
		}
		return SWIG_TypeError;
	}

#else
	// TODO: at some point drop support for SWIG<4.2.0 (drop this branch of ifdef)

	// This is copied from some old SWIG version from pystrings.swg
	inline int ZNC_SWIG_AsCharPtrAndSize(PyObject *obj, char** cptr, size_t* psize, int *alloc) {
#if PY_VERSION_HEX>=0x03000000
		if (PyUnicode_Check(obj))
#else
			if (PyString_Check(obj))
#endif
			{
				char *cstr; Py_ssize_t len;
#if PY_VERSION_HEX>=0x03000000
				if (!alloc && cptr) {
					/* We can't allow converting without allocation, since the internal
					   representation of string in Python 3 is UCS-2/UCS-4 but we require
					   a UTF-8 representation.
					   TODO(bhy) More detailed explanation */
					return SWIG_RuntimeError;
				}
				obj = PyUnicode_AsUTF8String(obj);
				PyBytes_AsStringAndSize(obj, &cstr, &len);
				if(alloc) *alloc = SWIG_NEWOBJ;
#else
				PyString_AsStringAndSize(obj, &cstr, &len);
#endif
				if (cptr) {
					if (alloc) {
						/*
						   In python the user should not be able to modify the inner
						   string representation. To warranty that, if you define
						   SWIG_PYTHON_SAFE_CSTRINGS, a new/copy of the python string
						   buffer is always returned.

						   The default behavior is just to return the pointer value,
						   so, be careful.
						 */
#if defined(SWIG_PYTHON_SAFE_CSTRINGS)
						if (*alloc != SWIG_OLDOBJ)
#else
							if (*alloc == SWIG_NEWOBJ)
#endif
							{
								*cptr = (char *)memcpy((char *)malloc((len + 1)*sizeof(char)), cstr, sizeof(char)*(len + 1));
								*alloc = SWIG_NEWOBJ;
							}
							else {
								*cptr = cstr;
								*alloc = SWIG_OLDOBJ;
							}
					} else {
#if PY_VERSION_HEX>=0x03000000
						assert(0); /* Should never reach here in Python 3 */
#endif
						*cptr = SWIG_Python_str_AsChar(obj);
					}
				}
				if (psize) *psize = len + 1;
#if PY_VERSION_HEX>=0x03000000
				Py_XDECREF(obj);
#endif
				return SWIG_OK;
			} else {
				swig_type_info* pchar_descriptor = ZNC_SWIG_pchar_descriptor();
				if (pchar_descriptor) {
					void* vptr = 0;
					if (SWIG_ConvertPtr(obj, &vptr, pchar_descriptor, 0) == SWIG_OK) {
						if (cptr) *cptr = (char *) vptr;
						if (psize) *psize = vptr ? (strlen((char *)vptr) + 1) : 0;
						if (alloc) *alloc = SWIG_OLDOBJ;
						return SWIG_OK;
					}
				}
			}
		return SWIG_TypeError;
	}
#endif

	inline int ZNC_SWIG_AsPtr_CString (PyObject * obj, CString **val) {
		char* buf = 0 ; size_t size = 0; int alloc = SWIG_OLDOBJ;
		if (SWIG_IsOK((ZNC_SWIG_AsCharPtrAndSize(obj, &buf, &size, &alloc)))) {
			if (buf) {
				if (val) *val = new CString(buf, size - 1);
				if (alloc == SWIG_NEWOBJ) delete[] buf;
				return SWIG_NEWOBJ;
			} else {
				if (val) *val = 0;
				return SWIG_OLDOBJ;
			}
		} else {
			static int init = 0;
			static swig_type_info* descriptor = 0;
			if (!init) {
				descriptor = SWIG_TypeQuery("CString" " *");
				init = 1;
			}
			if (descriptor) {
				CString *vptr;
				int res = SWIG_ConvertPtr(obj, (void**)&vptr, descriptor, 0);
				if (SWIG_IsOK(res) && val) *val = vptr;
				return res;
			}
		}
		return SWIG_ERROR;
	}
}

EOF
=b
bool OnFoo(const CString& x) {
	PyObject* pyName = Py_BuildValue("s", "OnFoo");
	if (!pyName) {
		CString s = GetPyExceptionStr();
		DEBUG("modpython: username/module/OnFoo: can't name method to call: " << s);
		return default;
	}
	PyObject* pyArg1 = Py_BuildValue("s", x.c_str());
	if (!pyArg1) {
		CString s = GetPyExceptionStr();
		DEBUG("modpython: username/module/OnFoo: can't convert parameter x to PyObject*: " << s);
		Py_CLEAR(pyName);
		return default;
	}
	PyObject* pyArg2 = ...;
	if (!pyArg2) {
		CString s = ...;
		DEBUG(...);
		Py_CLEAR(pyName);
		Py_CLEAR(pyArg1);
		return default;
	}
	PyObject* pyArg3 = ...;
	if (!pyArg3) {
		CString s = ...;
		DEBUG(...);
		Py_CLEAR(pyName);
		Py_CLEAR(pyArg1);
		Py_CLEAR(pyArg2);
		return default;
	}
	PyObject* pyRes = PyObject_CallMethodObjArgs(m_pyObj, pyName, pyArg1, pyArg2, pyArg3, nullptr);
	if (!pyRes) {
		CString s = ...;
		DEBUG("modpython: username/module/OnFoo failed: " << s);
		Py_CLEAR(pyName);
		Py_CLEAR(pyArg1);
		Py_CLEAR(pyArg2);
		Py_CLEAR(pyArg3);
		return default;
	}
	Py_CLEAR(pyName);
	Py_CLEAR(pyArg1);
	Py_CLEAR(pyArg2);
	Py_CLEAR(pyArg3);
	bool res = PyLong_AsLong(pyRes);
	if (PyErr_Occured()) {
		CString s = GetPyExceptionStr();
		DEBUG("modpython: username/module/OnFoo returned unexpected value: " << s);
		Py_CLEAR(pyRes);
		return default;
	}
	Py_CLEAR(pyRes);
	return res;
}
=cut

while (<$in>) {
	my ($type, $name, $args, $default) = /(\S+)\s+(\w+)\((.*)\)(?:=(\w+))?/ or next;
	$type =~ s/(EModRet)/CModule::$1/;
	$type =~ s/^\s*(.*?)\s*$/$1/;
	my @arg = map {
		my ($t, $v) = /^\s*(.*\W)\s*(\w+)\s*$/;
		$t =~ s/^\s*(.*?)\s*$/$1/;
		my ($tb, $tm) = $t =~ /^(.*?)\s*?(\*|&)?$/;
		{type=>$t, var=>$v, base=>$tb, mod=>$tm//'', pyvar=>"pyArg_$v", error=>"can't convert parameter '$v' to PyObject"}
	} split /,/, $args;

	unless (defined $default) {
		$default = "CModule::$name(" . (join ', ', map { $_->{var} } @arg) . ")";
	}

	unshift @arg, {type=>'$func$', var=>"", base=>"", mod=>"", pyvar=>"pyName", error=>"can't convert string '$name' to PyObject"};

	my $cleanup = '';

	say $out "$type CPyModule::$name($args) {";
	for my $a (@arg) {
		print $out "\tPyObject* $a->{pyvar} = ";
		given ($a->{type}) {
			when ('$func$') {
				say $out "Py_BuildValue(\"s\", \"$name\");";
			}
			when (/vector\s*<\s*.*\*\s*>/) {
				say $out "PyList_New(0);";
			}
			when (/(?:^|\s)CString/) { # not SCString
				if ($a->{base} eq 'CString' && $a->{mod} eq '&') {
					say $out "CPyRetString::wrap($a->{var});";
				} else {
					say $out "Py_BuildValue(\"s\", $a->{var}.c_str());";
				}
			}
			when (/^bool/) {
				if ($a->{mod} eq '&') {
					say $out "CPyRetBool::wrap($a->{var});";
				} else {
					say $out "Py_BuildValue(\"l\", (long int)$a->{var});";
				}
			}
			when (/^std::shared_ptr/) {
				say $out "SWIG_NewInstanceObj(new $a->{type}($a->{var}), SWIG_TypeQuery(\"$a->{type}*\"), SWIG_POINTER_OWN);";
			}
			when (/\*$/) {
				(my $t = $a->{type}) =~ s/^const//;
				say $out "SWIG_NewInstanceObj(const_cast<$t>($a->{var}), SWIG_TypeQuery(\"$t\"), 0);";
			}
			when (/&$/) {
				(my $b = $a->{base}) =~ s/^const//;
				say $out "SWIG_NewInstanceObj(const_cast<$b*>(&$a->{var}), SWIG_TypeQuery(\"$b*\"), 0);";
			}
			when (/(?:^|::)E/) { # Enumerations
				say $out "Py_BuildValue(\"i\", (int)$a->{var});";
			}
			default {
				my %letter = (
						'int' => 'i',
						'char' => 'b',
						'short int' => 'h',
						'long int' => 'l',
						'unsigned char' => 'B',
						'unsigned short' => 'H',
						'unsigned int' => 'I',
						'unsigned long' => 'k',
						'long long' => 'L',
						'unsigned long long' => 'K',
						'ssize_t' => 'n',
						'double' => 'd',
						'float' => 'f',
						);
				if (exists $letter{$a->{type}}) {
					say $out "Py_BuildValue(\"$letter{$a->{type}}\", $a->{var});"
				} else {
					say $out "...;";
				}
			}
		}
		say $out "\tif (!$a->{pyvar}) {";
		say $out "\t\tCString sPyErr = m_pModPython->GetPyExceptionStr();";
		say $out "\t\tDEBUG".'("modpython: " << (GetUser() ? GetUser()->GetUsername() : CString("<no user>")) << "/" << GetModName() << '."\"/$name: $a->{error}: \" << sPyErr);";
		print $out $cleanup;
		say $out "\t\treturn $default;";
		say $out "\t}";

		$cleanup .= "\t\tPy_CLEAR($a->{pyvar});\n";

		if ($a->{type} =~ /(vector\s*<\s*(.*)\*\s*>)/) {
			my ($vec, $sub) = ($1, $2);
			(my $cleanup1 = $cleanup) =~ s/\t\t/\t\t\t/g;
			my $dot = '.';
			$dot = '->' if $a->{mod} eq '*';
			say $out "\tfor (${vec}::const_iterator i = $a->{var}${dot}begin(); i != $a->{var}${dot}end(); ++i) {";
			say $out "\t\tPyObject* pyVecEl = SWIG_NewInstanceObj(*i, SWIG_TypeQuery(\"$sub*\"), 0);";
			say $out "\t\tif (!pyVecEl) {";
			say $out "\t\t\tCString sPyErr = m_pModPython->GetPyExceptionStr();";
			say $out "\t\t\tDEBUG".'("modpython: " << (GetUser() ? GetUser()->GetUsername() : CString("<no user>")) << "/" << GetModName() << '.
				"\"/$name: can't convert element of vector '$a->{var}' to PyObject: \" << sPyErr);";
			print $out $cleanup1;
			say $out "\t\t\treturn $default;";
			say $out "\t\t}";
			say $out "\t\tif (PyList_Append($a->{pyvar}, pyVecEl)) {";
			say $out "\t\t\tCString sPyErr = m_pModPython->GetPyExceptionStr();";
			say $out "\t\t\tDEBUG".'("modpython: " << (GetUser() ? GetUser()->GetUsername() : CString("<no user>")) << "/" << GetModName() << '.
				"\"/$name: can't add element of vector '$a->{var}' to PyObject: \" << sPyErr);";
			say $out "\t\t\tPy_CLEAR(pyVecEl);";
			print $out $cleanup1;
			say $out "\t\t\treturn $default;";
			say $out "\t\t}";
			say $out "\t\tPy_CLEAR(pyVecEl);";
			say $out "\t}";
		}
	}

	print $out "\tPyObject* pyRes = PyObject_CallMethodObjArgs(m_pyObj";
	print $out ", $_->{pyvar}" for @arg;
	say $out ", nullptr);";
	say $out "\tif (!pyRes) {";
	say $out "\t\tCString sPyErr = m_pModPython->GetPyExceptionStr();";
	say $out "\t\tDEBUG".'("modpython: " << (GetUser() ? GetUser()->GetUsername() : CString("<no user>")) << "/" << GetModName() << '."\"/$name failed: \" << sPyErr);";
	print $out $cleanup;
	say $out "\t\treturn $default;";
	say $out "\t}";

	$cleanup =~ s/\t\t/\t/g;

	print $out $cleanup;

	if ($type ne 'void') {
		say $out "\t$type result;";
		say $out "\tif (pyRes == Py_None) {";
		say $out "\t\tresult = $default;";
		say $out "\t} else {";
		given ($type) {
			when (/^(.*)\*$/) {
				say $out "\t\tint res = SWIG_ConvertPtr(pyRes, (void**)&result, SWIG_TypeQuery(\"$type\"), 0);";
				say $out "\t\tif (!SWIG_IsOK(res)) {";
				say $out "\t\t\tDEBUG(\"modpython: \" << (GetUser() ? GetUser()->GetUsername() : CString(\"<no user>\")) << \"/\" << GetModName() << \"/$name was expected to return '$type' but error=\" << res);";
				say $out "\t\t\tresult = $default;";
				say $out "\t\t}";
			}
			when ('CString') {
				say $out "\t\tCString* p = nullptr;";
				say $out "\t\tint res = ZNC_SWIG_AsPtr_CString(pyRes, &p);";
				say $out "\t\tif (!SWIG_IsOK(res)) {";
				say $out "\t\t\tDEBUG(\"modpython: \" << (GetUser() ? GetUser()->GetUsername() : CString(\"<no user>\")) << \"/\" << GetModName() << \"/$name was expected to return '$type' but error=\" << res);";
				say $out "\t\t\tresult = $default;";
				say $out "\t\t} else if (!p) {";
				say $out "\t\t\tDEBUG(\"modpython: \" << (GetUser() ? GetUser()->GetUsername() : CString(\"<no user>\")) << \"/\" << GetModName() << \"/$name was expected to return '$type' but returned nullptr\");";
				say $out "\t\t\tresult = $default;";
				say $out "\t\t} else result = *p;";
				say $out "\t\tif (SWIG_IsNewObj(res)) delete p;";
			}
			when ('CModule::EModRet') {
				say $out "\t\tlong int x = PyLong_AsLong(pyRes);";
				say $out "\t\tif (PyErr_Occurred()) {";
				say $out "\t\t\tCString sPyErr = m_pModPython->GetPyExceptionStr();";
				say $out "\t\t\tDEBUG".'("modpython: " << (GetUser() ? GetUser()->GetUsername() : CString("<no user>")) << "/" << GetModName() << '."\"/$name was expected to return EModRet but: \" << sPyErr);";
				say $out "\t\t\tresult = $default;";
				say $out "\t\t} else { result = (CModule::EModRet)x; }";
			}
			when ('bool') {
				say $out "\t\tint x = PyObject_IsTrue(pyRes);";
				say $out "\t\tif (-1 == x) {";
				say $out "\t\t\tCString sPyErr = m_pModPython->GetPyExceptionStr();";
				say $out "\t\t\tDEBUG".'("modpython: " << (GetUser() ? GetUser()->GetUsername() : CString("<no user>")) << "/" << GetModName() << '."\"/$name was expected to return EModRet but: \" << sPyErr);";
				say $out "\t\t\tresult = $default;";
				say $out "\t\t} else result = x ? true : false;";
			}
			default {
				say $out "\t\tI don't know how to convert PyObject to $type :(";
			}
		}
		say $out "\t}";
		say $out "\tPy_CLEAR(pyRes);";
		say $out "\treturn result;";
	} else {
		say $out "\tPy_CLEAR(pyRes);";
	}
	say $out "}\n";
}

sub getres {
	my $type = shift;
	given ($type) {
		when (/^(.*)\*$/)		 { return "pyobj_to_ptr<$1>(\"$type\")" }
		when ('CString')		  { return 'PString' }
		when ('CModule::EModRet') { return 'SvToEModRet' }
		when (/unsigned/)		 { return 'SvUV' }
		default				   { return 'SvIV' }
	}
}
