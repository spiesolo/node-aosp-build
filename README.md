# node-aosp-build

Android build scripts made for nodejs v6.10.3.

Below are patches need to be applied to nodejs v6.10.3.

```
diff --git a/deps/v8/include/v8.h b/deps/v8/include/v8.h
index c842b01..eb7f6df 100644
--- a/deps/v8/include/v8.h
+++ b/deps/v8/include/v8.h
@@ -18,6 +18,7 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <stdio.h>
+#include <cstddef> // for std::size_t
 #include <utility>
 #include <vector>
 
diff --git a/src/util.h b/src/util.h
index ecd5b12..a76b714 100644
--- a/src/util.h
+++ b/src/util.h
@@ -50,8 +50,12 @@ void DumpBacktrace(FILE* fp);
 #ifdef USE_TR1_TYPE_TRAITS
 template <typename T> using remove_reference = std::tr1::remove_reference<T>;
 #else
+#ifdef ANDROID
+template <typename T> using remove_reference = std::tr1::remove_reference<T>; // stlport use tr1
+#else
 template <typename T> using remove_reference = std::remove_reference<T>;
 #endif
+#endif
 
 #define FIXED_ONE_BYTE_STRING(isolate, string)                                \
   (node::OneByteString((isolate), (string), sizeof(string) - 1))
```

