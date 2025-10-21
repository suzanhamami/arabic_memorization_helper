import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory


// Buildscript for Android Gradle Plugin + Kotlin plugin
buildscript {
    val kotlinVersion = "2.0.20"
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.9.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
    }
}

// Flutter projects usually don't need `allprojects` in Kotlin DSL, but keeping it
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Custom build directory setup (optional)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

// Ensure subprojects depend on app evaluation
subprojects {
    project.evaluationDependsOn(":app")
}

// Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
