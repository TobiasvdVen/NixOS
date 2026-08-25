use nixos_tools_core::flake::Flake;
use nixos_tools_core::rebuild_action::RebuildAction;

pub struct AppModel
{
    pub flake: Flake,
    pub last_result: Option<Result<String, anyhow::Error>>
}

impl AppModel
{
    pub fn new(flake: Flake) -> Self
    {
        Self {
            flake,
            last_result: None
        }
    }

    pub fn update(&mut self, rebuild_action: RebuildAction)
    {
        self.last_result = Some(rebuild_action.execute());
    }
}
