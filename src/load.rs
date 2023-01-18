use crate::utils::which;
use clap::ArgMatches;
use log::{error, info};
use std::fs::{read_to_string, remove_file, File, canonicalize, create_dir_all};
use std::io::copy;
use std::os::unix::fs::symlink;
use std::path::Path;
use std::process::Command;
use serde_derive::Deserialize;
use toml::from_str;
use dirs;

#[derive(Deserialize)]
struct Data {
    dotfiles: Vec<Symlink>,
}

#[derive(Deserialize)]
struct Symlink {
    source: String,
    target_dir: String,
    target_file: String,
}

pub fn init(args: &ArgMatches) {
    info!(
        "beginning load::  update: {:?} | link: {:?}",
        args.get_flag("update"),
        args.get_flag("link")
    );
    install_homebrew();
    link_dotfiles();
}

fn install_homebrew() {
    if which("brew") {
        info!("homebrew already installed")
    } else {
        info!("installing homebrew...");

        let resp = reqwest::blocking::get(
            "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh",
        )
            .expect("request failed");
        let body = resp.text().expect("body invalid");
        let mut out = File::create("homebrew_install.sh").expect("failed to create file");
        copy(&mut body.as_bytes(), &mut out).expect("failed to copy content");

        info!("homebrew install script downloaded");
        let install_script =
            read_to_string("homebrew_install.sh").expect("Should have been able to read the file");

        Command::new("/bin/bash")
            .env("NONINTERACTIVE", "1")
            .arg("-c")
            .arg(install_script)
            .spawn()
            .expect("homebrew installation failed to start");

        match remove_file(Path::new("homebrew_install.sh")) {
            Ok(_) => info!("homebrew install script removed"),
            Err(e) => error!("error removing homebrew script, {:?}", e),
        };
    }
}

fn link_dotfiles() {
    let filename = Path::new("../config/symlinks.toml");
    let contents = read_to_string(filename).expect("error reading symlink config file");
    let data: Data = from_str(&contents).expect("error loading data from config file");


    for link in data.dotfiles {
        let source = canonicalize(Path::new(&link.source)).unwrap();

        let target_dir = dirs::home_dir().unwrap().join(&link.target_dir);
        create_dir_all(&target_dir).expect("failed to create target directory path");

        let target = target_dir.join(&link.target_file);
        if target.exists() {
            remove_file(&target).expect("failed to remove file");
        }
        match symlink(&source, &target) {
            Ok(_) => info!("symlink created, {:?} => {:?}", source, target),
            Err(e) => error!(
                "error creating symlink, {:?} => {:?} : {:?}",
                source, target, e
            ),
        };
    }
}