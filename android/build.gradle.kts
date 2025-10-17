buildscript {
    ext {
        // Update Kotlin if needed
        kotlin_version = '2.0.20'
    }
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // 🔥 Upgrade to AGP 8.9.0 to match androidx.core 1.17.0 requirement
        classpath 'com.android.tools.build:gradle:8.9.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Keep your custom build directory setup
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
