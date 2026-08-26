use std::path::PathBuf;

use nixos_tools_core::flake::Flake;
use nixos_tools_core::rebuild_action::RebuildAction;
use nixos_tools_core::rebuild_configuration::RebuildConfiguration;

pub struct AppModel
{
    pub working_directory: PathBuf,
    pub rebuild_configurations: Vec<RebuildConfiguration>,
    pub last_result: Option<Result<String, anyhow::Error>>
}

impl AppModel
{
    pub fn new(
        working_directory: PathBuf,
        rebuild_configurations: Vec<RebuildConfiguration>
    ) -> Self
    {
        Self {
            working_directory,
            rebuild_configurations,
            last_result: None
        }
    }

    pub fn from_flake(flake: Flake) -> Self
    {
        let rebuild_configurations = flake
            .output
            .nixos_configurations
            .into_iter()
            .map(|c| {
                RebuildConfiguration {
                    name: c.0,
                    nixos_configuration: c.1
                }
            })
            .collect();

        Self::new(flake.path, rebuild_configurations)
    }

    pub fn update(&mut self, rebuild_action: RebuildAction)
    {
        self.last_result = Some(rebuild_action.execute());
    }
}
